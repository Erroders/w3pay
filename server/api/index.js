import express from "express";
import createChannelController from "../controllers/createChannel.js";

const app = express();
app.use(express.json());

app.get("/createChannel", createChannelController);

app.listen(3000, () => {
  console.log("Listen on the port 3000...");
});
