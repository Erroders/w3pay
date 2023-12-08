import { MongoClient, ServerApiVersion } from "mongodb";
import dotenv from "dotenv";
dotenv.config();

async function connectMongoDB() {
  const connectionString = process.env.ATLAS_URI || "";
  const client = new MongoClient(connectionString, {
    serverApi: {
      version: ServerApiVersion.v1,
      strict: true,
      deprecationErrors: true,
    },
  });

  try {
    await client.connect();
    console.log("Connected successfully to MongoDB server");
  } catch (e) {
    console.error(e);
  }

  return client;
}

export default connectMongoDB;
