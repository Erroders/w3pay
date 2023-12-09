import { newMockEvent } from "matchstick-as"
import { ethereum, Address } from "@graphprotocol/graph-ts"
import { ChannelUpdate } from "../generated/Contract/Contract"

export function createChannelUpdateEvent(
  walletA: Address,
  walletB: Address,
  pc: ethereum.Tuple
): ChannelUpdate {
  let channelUpdateEvent = changetype<ChannelUpdate>(newMockEvent())

  channelUpdateEvent.parameters = new Array()

  channelUpdateEvent.parameters.push(
    new ethereum.EventParam("walletA", ethereum.Value.fromAddress(walletA))
  )
  channelUpdateEvent.parameters.push(
    new ethereum.EventParam("walletB", ethereum.Value.fromAddress(walletB))
  )
  channelUpdateEvent.parameters.push(
    new ethereum.EventParam("pc", ethereum.Value.fromTuple(pc))
  )

  return channelUpdateEvent
}
