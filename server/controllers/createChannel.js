function createChannelController(req, res) {
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

export default createChannelController;
