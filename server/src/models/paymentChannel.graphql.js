import graphql from "@apollo/client";

const APIURL =
  "https://api.studio.thegraph.com/query/60957/w3pay-1442/version/latest";

const client = new graphql.ApolloClient({
  uri: APIURL,
  cache: new graphql.InMemoryCache(),
});

export async function executeQuery(query) {
  return await client
    .query({
      query: graphql.gql(query),
    })
    .then((data) => {
      console.log("Query executed successfully!");
      return data.data;
    })
    .catch((error) => {
      console.log("Error while executing query: ", error);
    });
}

export async function getChannel(channelId) {
  const query = `
    {
      paymentChannels(
        where: {
          id: "${channelId}"
        }
      ) {
        id
        walletA
        walletB
        proxyWalletA
        proxyWalletB
        status
        challengePeriod
        initialState {
          balanceA
          balanceB
          index
        }
        finalState {
          balanceA
          balanceB
          index
        }
      }
    }
  `;
  return executeQuery(query);
}

getChannel("0x8b57190f99c8c41e47a9210452a0008468c3eed50b4c3c8a30a3831950dca1d6").then(data => console.log(JSON.stringify(data, null, 2))).catch(console.log)