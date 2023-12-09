import { ChannelUpdate as ChannelUpdateEvent } from "../generated/Contract/Contract";
import { PaymentChannel, ChannelState } from "../generated/schema";

export function handleChannelUpdate(event: ChannelUpdateEvent): void {
  let channel = PaymentChannel.load(event.params.channelid.toHex());
  if (!channel) {
    channel = new PaymentChannel(event.params.channelid.toHex());
    channel.walletA = event.params.walletA;
    channel.walletB = event.params.walletB;
    channel.proxyWalletA = event.params.pc.proxyA;
    channel.proxyWalletB = event.params.pc.proxyB;
    channel.status = handleStatus(event.params.pc.status as u32);
    channel.challengePeriod = event.params.pc.challengePeriod;

    const initial = new ChannelState(
      event.params.channelid.toHex() + "initial"
    );
    initial.balanceA = event.params.pc.balanceA;
    initial.balanceB = event.params.pc.balanceB;
    initial.index = event.params.pc.index;
    initial.save();

    channel.initialState = event.params.channelid.toHex() + "initial";
    channel.save();
  } else {
    channel.status = handleStatus(event.params.pc.status as u32);

    const final = new ChannelState(event.params.channelid.toHex() + "final");
    final.balanceA = event.params.pc.balanceA;
    final.balanceB = event.params.pc.balanceB;
    final.index = event.params.pc.index;
    final.save();

    channel.finalState = event.params.channelid.toHex() + "final";
    channel.save();
  }
}

function handleStatus(statusFromChain: u32): string {
  switch (statusFromChain) {
    case 0:
      return "ACTIVE";
    case 1:
      return "PENDING";
    case 2:
      return "CLOSED";
    default:
      return "";
  }
}
