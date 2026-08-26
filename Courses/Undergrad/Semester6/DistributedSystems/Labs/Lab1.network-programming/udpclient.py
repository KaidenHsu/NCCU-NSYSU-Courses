import socket

# Server address and port
server_address = ('127.0.0.1', 20213)
message = b'This is a test from python client'

# Create a UDP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

try:
    # Sending the message
    print('Sending: ', message.decode())
    sent = sock.sendto(message, server_address)

    # Receiving the response
    # buffer size 4096 bytes
    data, server = sock.recvfrom(4096)
    # Decode bytes to string and print the response
    print('Received: ', data.decode())

finally:
    print('closing socket')
    sock.close()