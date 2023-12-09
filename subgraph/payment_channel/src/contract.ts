import { ChannelUpdate as ChannelUpdateEvent } from "../generated/Contract/Contract"
import { ChannelUpdate } from "../generated/schema"

export function handleChannelUpdate(event: ChannelUpdateEvent): void {
  let entity = new ChannelUpdate(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.walletA = event.params.walletA
  entity.walletB = event.params.walletB
  entity.pc_walletA = event.params.pc.walletA
  entity.pc_proxyA = event.params.pc.proxyA
  entity.pc_balanceA = event.params.pc.balanceA
  entity.pc_walletB = event.params.pc.walletB
  entity.pc_proxyB = event.params.pc.proxyB
  entity.pc_balanceB = event.params.pc.balanceB
  entity.pc_metadata = event.params.pc.metadata
  entity.pc_status = event.params.pc.status

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}
