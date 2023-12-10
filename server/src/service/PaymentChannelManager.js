import PaymentChannelABI from "../abis/Contract.json";
const contracts = require("../../contracts.json");
import { Contract } from "ethers";

export class PaymentChannel {
  static contract(networkId, signer) {
    return new Contract(contracts[networkId], PaymentChannelABI, signer);
  }

  static async createChannel(
    networkId,
    signer,
    walletA,
    proxyA,
    walletB,
    proxyB,
    amount
  ) {
    const contract = PaymentChannel.contract(networkId, signer);
    const tx = await contract.createChannel(
      walletA,
      proxyA,
      walletB,
      proxyB,
      amount
    );
    const channelId = await tx.wait();
    return channelId;
  }

  static async closeChannel(
    networkId,
    signer,
    cs,
    sigA,
    sigB
  ) {
    const contract = PaymentChannel.contract(networkId, signer);
    const tx = await contract.closeChannel(
      cs,
      sigA,
      sigB
    );
    const channelStatus = await tx.wait();
    return channelStatus;
  }


  static async requestCloseChannel(
    networkId,
    signer,
    cs,
    sigA,
    sigB
  ) {
    const contract = PaymentChannel.contract(networkId, signer);
    const tx = await contract.requestCloseChannel(
      cs,
      sigA,
      sigB
    );
    const channelStatus = await tx.wait();
    return channelStatus;
  }

  async challengeCloseChannel(
    networkId,
    signer,
    cs,
    sigA,
    sigB
  ) {
    const contract = PaymentChannel.contract(networkId, signer);
    const tx = await contract.challengeCloseChannel(
      cs,
      sigA,
      sigB
    );
    const channelStatus = await tx.wait();
    return channelStatus;
  }

}