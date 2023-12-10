# server
- 



# frontend
Saved in ENV:
    - Intermediary Pub Key
    - Deployed smart contract address
    - Contract ABI
2. Create new PVT key pair of client and save this.
3. Give Allowance of client to PaymentChannelContract of amount taken as input from user.
4. Get Intermediary details from websocket
5. Create channel [with proxyB == walletB]
6. TRANSFER
    1. Create HTLC and its random key
    2. Send this HTLC without key to server via websocket
    3. Send this random key to recipient address via this same socket.




1. Give Allowance of Intermediary to PaymentChannelContract [only once]