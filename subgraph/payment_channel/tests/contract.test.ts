import {
  assert,
  describe,
  test,
  clearStore,
  beforeAll,
  afterAll
} from "matchstick-as/assembly/index"
import { Address } from "@graphprotocol/graph-ts"
import { ChannelUpdate } from "../generated/schema"
import { ChannelUpdate as ChannelUpdateEvent } from "../generated/Contract/Contract"
import { handleChannelUpdate } from "../src/contract"
import { createChannelUpdateEvent } from "./contract-utils"

// Tests structure (matchstick-as >=0.5.0)
// https://thegraph.com/docs/en/developer/matchstick/#tests-structure-0-5-0

describe("Describe entity assertions", () => {
  beforeAll(() => {
    let walletA = Address.fromString(
      "0x0000000000000000000000000000000000000001"
    )
    let walletB = Address.fromString(
      "0x0000000000000000000000000000000000000001"
    )
    let pc = "ethereum.Tuple Not implemented"
    let newChannelUpdateEvent = createChannelUpdateEvent(walletA, walletB, pc)
    handleChannelUpdate(newChannelUpdateEvent)
  })

  afterAll(() => {
    clearStore()
  })

  // For more test scenarios, see:
  // https://thegraph.com/docs/en/developer/matchstick/#write-a-unit-test

  test("ChannelUpdate created and stored", () => {
    assert.entityCount("ChannelUpdate", 1)

    // 0xa16081f360e3847006db660bae1c6d1b2e17ec2a is the default address used in newMockEvent() function
    assert.fieldEquals(
      "ChannelUpdate",
      "0xa16081f360e3847006db660bae1c6d1b2e17ec2a-1",
      "walletA",
      "0x0000000000000000000000000000000000000001"
    )
    assert.fieldEquals(
      "ChannelUpdate",
      "0xa16081f360e3847006db660bae1c6d1b2e17ec2a-1",
      "walletB",
      "0x0000000000000000000000000000000000000001"
    )
    assert.fieldEquals(
      "ChannelUpdate",
      "0xa16081f360e3847006db660bae1c6d1b2e17ec2a-1",
      "pc",
      "ethereum.Tuple Not implemented"
    )

    // More assert options:
    // https://thegraph.com/docs/en/developer/matchstick/#asserts
  })
})
