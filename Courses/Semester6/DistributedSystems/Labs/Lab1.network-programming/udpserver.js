// Import the dgram module for UDP socket operations
const dgram = require('dgram');
// Create a UDP socket for IPv4
const server = dgram.createSocket('udp4');

// Handle errors that occur within the server
server.on('error', (err) => {
    // Print the error stack trace
    console.log(`server error:\n${err.stack}`);
    server.close();
});

// Event listener for receiving messages
server.on('message', (msg, rinfo) => {
    console.log(`server got: ${msg} from ${rinfo.address}:${rinfo.port}`);

    // Prepend the client's port number to the received message
    const message = `${rinfo.port}: ${msg}`;

    // Send the modified message back to the client
    server.send(message, rinfo.port, rinfo.address, () => {
        console.log('Message sent back to client');
        // Close the server after sending the message
        server.close();
    });
});

// Listener for when the server starts listening
server.on('listening', () => {
    // Get the address information of the server
    const address = server.address();
    // Log the listening address and port
    console.log(`server listening ${address.address}:${address.port}`);
});

// Server listens on port 20213
server.bind(20213);
