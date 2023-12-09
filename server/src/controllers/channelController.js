import connectMongoDB from "../mongo/index.js";
import { uuid } from "uuidv4";

export async function createChannelController(req, res) {
  const client = await connectMongoDB();
  const db = client.db("payment_channels");

  await db.collection("channels").insertMany([
    {
      id: uuid(),
      from: "Alice",
      to: "Bob",
      amount: 100,
      signature: "Alice's signature",
      timestamp: 123456789,
    },
    {
      id: uuid(),
      from: "Barbara",
      to: "Cabin",
      amount: 120,
      signature: "Barbara's signature",
      timestamp: 123456789,
    },
    {
      id: uuid(),
      from: "Danniel",
      to: "Bob",
      amount: 150,
      signature: "Danniel's signature",
      timestamp: 123456789,
    },
  ]);

  res.send({
    message: "Create channel successfully!",
    data: {
      channelName: "channelName",
      channelType: "channelType",
      channelDescription: "channelDescription",
      channelPassword: "channelPassword",
      channelOwner: "channelOwner",
      channelMembers: "channelMembers",
      channelCreatedAt: "channelCreatedAt",
      channelUpdatedAt: "channelUpdatedAt",
    },
    status: "success",
    code: 200,
  });
}

export async function getChannelController(req, res) {
  const client = await connectMongoDB();
  const db = client.db("payment_channels");
  const data = await db.collection("channels").find().toArray();

  res.send({
    message: "Get channels successfully",
    data: data,
    status: "success",
    code: 200,
  });
}
