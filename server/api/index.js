import express from "express";
import dotenv from "dotenv";
dotenv.config();
import {
  createChannelController,
  getChannelController,
} from "../controllers/channelController.js";

const app = express();
const port = process.env.PORT || 3000;
app.use(express.json());

app.get("/createChannel", createChannelController);
app.get("/getChannels", getChannelController);

app.listen(port, () => {
  console.log(`Listen on the port ${port}...`);
});
