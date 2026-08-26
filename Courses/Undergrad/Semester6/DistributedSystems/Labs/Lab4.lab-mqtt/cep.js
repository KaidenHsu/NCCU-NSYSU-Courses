const mqtt = require('mqtt');
const client = mqtt.connect('mqtt://localhost');
client.subscribe('EVENT');

let eventSeq = ['CO', 'CF', 'DO', 'DF'];

client.on('message', function (topic, message) {
    message = message.toString(); // Convert message from Buffer to String
    let expectedEvent = eventSeq[0];

    console.log('Received message:', message);
    console.log('Waiting for:', expectedEvent);

    if (message === expectedEvent) {
        eventSeq.shift(); // Remove the first element as it matches
        console.log('Match found. Current sequence:', eventSeq);
    }

    if (eventSeq.length === 0) { // Check if the sequence is complete
        client.publish('EVENT', 'LEAVE'); // Publish 'LEAVE' to the 'EVENT' topic
        console.log('Sequence complete. Publishing LEAVE.');
        eventSeq = ['CO', 'CF', 'DO', 'DF']; // Reset the sequence
    }
});