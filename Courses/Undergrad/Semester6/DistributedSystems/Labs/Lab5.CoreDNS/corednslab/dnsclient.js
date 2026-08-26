const dns2 = require('dns2');

// Setup the DNS client configuration
const { UDPClient } = dns2;
const resolve = UDPClient({
  dns: '127.0.0.1',  // CoreDNS IP address
  port: 1053,        // The port on which CoreDNS is listening
  recursive: false
});

// asynchronous function to perform DNS query
async function queryDNS() {
  try {
    const response = await resolve('nccu.lab', 'TXT');
    console.log('DNS Query Response:', response.answers);
  } catch (error) {
    console.error('Error performing DNS query:', error);
  }
}

// Execute the DNS query function
queryDNS();
