// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract PaymentChannelManager {
  IERC20 token;
  uint256 challengePeriod; // in blocks

  enum ChannelStatus {
    ACTIVE,
    PENDING,
    CLOSED
  }

  struct PaymentChannel {
    address walletA;
    address proxyA;
    uint balanceA;
    address walletB;
    address proxyB;
    uint balanceB;
    uint index;
    uint challengePeriod;
    ChannelStatus status;
  }

  struct ChannelState {
    bytes32 channelId;
    uint index;
    uint balanceA;
    uint balanceB;
    bytes metadata;
  }

  struct HTLCState {
    bytes32 id;
    address sender;
    uint amount;
    bytes32 hashlock;
    uint timelock;
    bytes32 key;
  }

  mapping(bytes32 => PaymentChannel) channels;

  event ChannelUpdate(bytes32 indexed channelid, address indexed walletA, address indexed walletB, PaymentChannel pc);

  constructor(address _tokenAddress, uint256 _challengePeriod) payable {
    token = IERC20(_tokenAddress);
    challengePeriod = _challengePeriod;
  }

  function getChannelId(PaymentChannel memory _pc) public pure returns (bytes32 channelId) {
    channelId = keccak256(abi.encode(_pc.walletA, _pc.proxyA, _pc.walletB, _pc.proxyB));
  }

  function createChannel(
    address _walletA,
    address _proxyA,
    address _walletB,
    address _proxyB,
    uint _amount
  ) public returns (bytes32 channelId) {
    token.transferFrom(_walletA, address(this), _amount);
    token.transferFrom(_walletB, address(this), _amount);
    PaymentChannel memory pc = PaymentChannel(
      _walletA,
      _proxyA,
      _amount,
      _walletB,
      _proxyB,
      _amount,
      0,
      0,
      ChannelStatus.ACTIVE
    );

    channelId = getChannelId(pc);
    channels[channelId] = pc;
    emit ChannelUpdate(channelId, _walletA, _walletB, pc);
  }

  function getChannelState(bytes32 _channelId) public view returns (ChannelState memory state) {
    PaymentChannel memory pc = channels[_channelId];
    state = ChannelState(_channelId, 0, pc.balanceA, pc.balanceB, "");
  }

  function getChannelStateHash(ChannelState memory _cs) public pure returns (bytes32 stateHash) {
    stateHash = keccak256(abi.encode(_cs.channelId, _cs.index, _cs.balanceA, _cs.balanceB, _cs.metadata));
  }

  function closeChannel(
    ChannelState memory _cs,
    bytes calldata _sigA,
    bytes calldata _sigB
  ) public returns (ChannelStatus status) {
    PaymentChannel storage pc = channels[_cs.channelId];

    require(pc.status == ChannelStatus.ACTIVE, "Inactive channel");
    isValidState(_cs, _sigA, _sigB);
    require(keccak256(_cs.metadata) == keccak256(bytes("CLOSE")), "Invalid close msg");

    pc.balanceA = _cs.balanceA;
    pc.balanceB = _cs.balanceB;
    pc.status = ChannelStatus.CLOSED;

    token.transfer(pc.walletA, _cs.balanceA);
    token.transfer(pc.walletB, _cs.balanceB);

    return pc.status;
  }

  function requestCloseChannel(
    ChannelState memory _cs,
    bytes calldata _sigA,
    bytes calldata _sigB
  ) public returns (ChannelStatus status) {
    PaymentChannel storage pc = channels[_cs.channelId];

    require(pc.status == ChannelStatus.ACTIVE, "Inactive channel");
    isValidState(_cs, _sigA, _sigB);

    HTLCState[] memory htlcs = abi.decode(_cs.metadata, (HTLCState[]));
    for (uint i = 0; i < htlcs.length; i++) {
      HTLCState memory htlc = htlcs[i];
      if (htlc.timelock > block.number && htlc.key != bytes32(0) && htlc.hashlock == keccak256(abi.encode(htlc.key))) {
        if (htlc.sender == pc.walletA) {
          _cs.balanceA -= htlc.amount;
          _cs.balanceB += htlc.amount;
        } else {
          _cs.balanceB -= htlc.amount;
          _cs.balanceA += htlc.amount;
        }
      }
    }
    pc.balanceA = _cs.balanceA;
    pc.balanceB = _cs.balanceB;
    pc.index = _cs.index;
    pc.challengePeriod = block.number + challengePeriod;
    pc.status = ChannelStatus.PENDING;
  }

  function isValidState(ChannelState memory _channelState, bytes calldata _sigA, bytes calldata _sigB) public view {
    PaymentChannel memory pc = channels[_channelState.channelId];

    require(pc.balanceA + pc.balanceB == _channelState.balanceA + _channelState.balanceB, "Balance mismatch");

    bytes32 stateHash = getChannelStateHash(_channelState);
    require(isValidSignature(pc.proxyA, stateHash, _sigA), "Invalid A's signature");
    require(isValidSignature(pc.proxyB, stateHash, _sigB), "Invalid B's signature");
  }

  function isValidSignature(address signer, bytes32 hash, bytes memory signature) internal pure returns (bool) {
    (address recovered, ECDSA.RecoverError error, ) = ECDSA.tryRecover(hash, signature);
    return error == ECDSA.RecoverError.NoError && recovered == signer;
  }
}
