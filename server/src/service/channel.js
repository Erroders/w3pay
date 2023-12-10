import connectMongoDB from "../mongo/index.js";
import { executeQuery } from "../models/paymentChannel.graphql.js";


const client = await connectMongoDB();
const db = client.db("payment_channels");

export class Channel {
  async fetchChannel(channelId) {
    let channel = db.collection("channels").findOne({ channelId })
    if (channel) return channel;
    const result = await executeQuery(channelId);
    return result[0];
  }

  async createChannel(sigA, sigB) {
    const result = await executeQuery(channelId);
    const data = result[0];
    db.collection("channels").insertOne({
      id: data.id,
      walletA: data.walletA,
      walletB: data.walletB,
      proxyA: data.proxyWalletA,
      proxyB: data.proxyWalletB,
      status: 'ACTIVE',
      state: {
        channelId: data.id,
        index: 0,
        balanceA: data.initialState.balanceA,
        balanceB: data.initialState.balanceB,
        metadata: "",
        sigA: sigA,
        sigB: sigB
      }
    })

  }
}