const axios = require('axios');

function sendMessage() {
  const url = 'http://127.0.0.1:8645/lightpush/v1/message';
  const headers = {
    'accept': 'text/plain',
    'content-type': 'application/json',
  };

  const data = {
    pusbsubTopic: 'string',
    message: {
      payload: 'test',
      contentTopic: 'string',
      version: 0,
      timestamp: 0,
      ephemeral: false,
    },
  };

  axios.post(url, data, { headers })
    .then(response => {
      console.log('Response:', response.data);
    })
    .catch(error => {
      console.error('Error:', error.response ? error.response.data : error.message);
    });
}

// Call the function
sendMessage();
