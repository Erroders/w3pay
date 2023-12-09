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
    CREATED,
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
    bytes metadata;
    ChannelStatus status;
  }

  struct ChannelState {
    bytes32 channelId;
    uint index;
    uint balanceA;
    uint balanceB;
    bytes metadata;
  }

  mapping(bytes32 => PaymentChannel) channels;

  event ChannelUpdate(address indexed walletA, address indexed walletB, PaymentChannel pc);

  constructor(address _tokenAddress, uint256 _challengePeriod) payable {
    token = IERC20(_tokenAddress);
    challengePeriod = _challengePeriod;
  }

  function getChannelId(PaymentChannel memory _pc) public pure returns (bytes32 channelId) {
    channelId = keccak256(
      abi.encode(_pc.walletA, _pc.proxyA, _pc.balanceA, _pc.walletB, _pc.proxyB, _pc.balanceB, _pc.metadata)
    );
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
      "",
      ChannelStatus.CREATED
    );

    channelId = getChannelId(pc);
    channels[channelId] = pc;
    emit ChannelUpdate(_walletA, _walletB, pc);
  }

  function getChannelState(bytes32 _channelId) public view returns (ChannelState memory state) {
    PaymentChannel memory pc = channels[_channelId];
    state = ChannelState(_channelId, 0, pc.balanceA, pc.balanceB, pc.metadata);
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
    pc.metadata = _cs.metadata;
    pc.status = ChannelStatus.CLOSED;

    token.transfer(pc.walletA, _cs.balanceA);
    token.transfer(pc.walletB, _cs.balanceB);

    return pc.status;
  }

  function isValidState(
    ChannelState memory _channelState,
    bytes calldata _sigA,
    bytes calldata _sigB
  ) public view returns (bool validity) {
    PaymentChannel memory pc = channels[_channelState.channelId];

    require(pc.balanceA + pc.balanceB == _channelState.balanceA + _channelState.balanceB, "Balance mismatch");

    bytes32 stateHash = getChannelStateHash(_channelState);
    require(isValidSignature(pc.proxyA, stateHash, _sigA), "Invalid A's signature");
    require(isValidSignature(pc.proxyB, stateHash, _sigB), "Invalid B's signature");
    return true;
  }

  function isValidSignature(address signer, bytes32 hash, bytes memory signature) internal pure returns (bool) {
    (address recovered, ECDSA.RecoverError error, ) = ECDSA.tryRecover(hash, signature);
    return error == ECDSA.RecoverError.NoError && recovered == signer;
  }
}
