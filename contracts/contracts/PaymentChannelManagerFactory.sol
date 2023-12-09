// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";
import {PaymentChannelManager} from "./PaymentChannelManager.sol";

contract PaymentChannelManagerFactory {
  event NewPaymentManager(address newManager, address token, uint challengePeriod);

  function deployNewManager(address _token, uint _challengePeriod) public returns (address managerAddress) {
    PaymentChannelManager pcm = new PaymentChannelManager(_token, _challengePeriod);
    emit NewPaymentManager(managerAddress, _token, _challengePeriod);
    return address(pcm);
  }
}
