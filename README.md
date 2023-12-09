# w3pay
UPI for web3

## Introduction

A fast, secure and gas-less payment system for the web3. Inspired by Bitcoin's Lightning Network, w3pay allows you to send and receive payments in payment channels (PCs) established over the Waku Protocol. But unlike the Lightning Network, only one PC is required for all payments. This is possible because w3pay uses signed transaction records to keep off-chain track of the balances of the PCs. To start using w3pay, user needs to topup with USDT balance in the smart contract and execute as many transactions off-chain. The users funds are locked securely in the smart contract and can be withdrawn at any time by closing the PC, receiving the balance after final settlement.

## Problems Solved

Token transfers on EThereum are expensive and slow. Now if L2s comes to rescue, it brings interoperability challenges along. We see this as a major problem for the adoption of blockchain in daily transactions. w3pay solves this problem by allowing users to execute transactions off-chain and only settle the final balances on-chain. This aids for instant, private, cross-chain transactions at a fraction of the cost.

## Benefits
1. **Fast**: Transactions are executed off-chain and only the final balances are settled on-chain. This allows for instant transactions.
2. **Signature Exchanges**: Users exchange digitally signed messages or transactions that represent changes in their wallet balances. These messages are cryptographically secure and can be verified by the blockchain when needed.
3. **Validation and Security**: The signatures ensure the security and authenticity of transactions without the need for immediate on-chain validation. This method speeds up transactions and reduces the load on the blockchain.
4. **Transparency and Security**: While off-chain transactions are private between involved parties, the final settlement on the blockchain ensures transparency and immutability, providing a secure audit trail of transactions.

## How it works
