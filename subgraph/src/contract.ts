import { ChannelUpdate as ChannelUpdateEvent } from "../generated/Contract/Contract";
import { Channel } from "../generated/schema";

export function handleChannelUpdate(event: ChannelUpdateEvent): void {
  let channel = Channel.load(event.params.channelId.toHex());
  if (!channel) {
    channel = new Channel(event.params.channelId.toHex());

    channel.walletA = event.params.walletA;
    channel.walletB = event.params.walletB;
    channel.proxyWalletA = event.params.pc.proxyA;
    channel.proxyWalletB = event.params.pc.proxyB;
    channel.amountA = event.params.pc.balanceA;
    channel.amountB = event.params.pc.balanceB;
    channel.metadata = event.params.pc.metadata;
    channel.status = handleStatus(event.params.pc.status as u32);

    channel.save();
  }
}

function handleStatus(statusFromChain: u32): string {
  switch (statusFromChain) {
    case 0:
      return "CREATED";
    case 1:
      return "ACTIVE";
    case 2:
      return "PENDING";
    case 3:
      return "CLOSED";
    default:
      return "";
  }
}
