import { AbiCoder, getBytes, hashMessage } from "ethers";

export class Mediator {
  signChannelState(signer, cs) {
    const encodedData = AbiCoder.defaultAbiCoder.encode(["bytes32", "uint256", "uint256", "uint256", "bytes"], [cs.channelId, cs.index, cs.balanceA, cs.balanceB, cs.metadata]);
    const bytes = getBytes(encodedData);
    // const hash = hashMessage(bytes);
    // return signer.signMessage(getBytes(hash));
    return signer.signMessage(bytes);
  }

  //  struct HTLCState {
  //   bytes32 id;
  //   address sender;
  //   uint amount;
  //   bytes32 hashlock;
  //   uint timelock;
  //   bytes32 key;
  // }

  createHTLC (signer, sender, amount, hashlock, timelock) {
    const encodedData = AbiCoder.defaultAbiCoder.encode(["uint256", "bytes32", "uint256", "bytes32"], [amount, hashlock, timelock, key]);
    const bytes = getBytes(encodedData);
    const hash = hashMessage(bytes);
    return signer.signMessage(getBytes(hash));
  }
}