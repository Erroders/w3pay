import express from "express";
import dotenv from "dotenv";
dotenv.config();
import createChannelController from "../controllers/createChannel.js";
import connectMongoDB from "../mongo/index.js";

const app = express();
const port = process.env.PORT || 3000;
app.use(express.json());

const connection = await connectMongoDB();
connection.db("payment_channels");

app.get("/createChannel", createChannelController);

app.listen(port, () => {
  console.log(`Listen on the port ${port}...`);
});
