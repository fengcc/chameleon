#!/usr/bin/python

import socket, select
import Queue
from database_operation import *

BUFSIZE = 52
GET = '0'
SET = '1'

serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
serversocket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server_address = ('', 9999)
serversocket.bind(server_address)
serversocket.listen(10)
serversocket.setblocking(0)
timeout = 10
epoll = select.epoll()
epoll.register(serversocket.fileno(), select.EPOLLIN)
message_queues = {}

fd_to_socket = {serversocket.fileno():serversocket}

while True:
    events = epoll.poll(timeout)
    if not events:
        print "epoll timeout"
        continue
    for fd, event in events:
        socket = fd_to_socket[fd]
        
        if event &select.EPOLLIN:
            if socket == serversocket:
                connection, address = serversocket.accept()
                print "accept new connection: ", address
                connection.setblocking(0)
                epoll.register(connection.fileno(), select.EPOLLIN | select.EPOLLET)
                fd_to_socket[connection.fileno()] = connection
                message_queues[connection] = Queue.Queue()
            else:
                data = socket.recv(BUFSIZE)
                if data:
                    print "receive message: ", data
                    print "from client: ", socket.getpeername()
                    
                    if data[0] == GET:
                        mac = data[1:18]
                        
                        # database operation: select
                        result = db_get(mac)
                        
                        if not result:
                            epoll.unregister(fd)
                            fd_to_socket[fd].close()
                            del fd_to_socket[fd]
                            del message_queues[connection]
                        else:
                            message_queues[socket].put(result[0])
                            epoll.modify(fd, select.EPOLLOUT | select.EPOLLET)
                    else: # SET
                        mac = data[1:18]
                        strpsk = data[18:]
                        
                        # database operation: insert
                        db_set(mac, strpsk)

                        epoll.unregister(fd)
                        fd_to_socket[fd].close()
                        del fd_to_socket[fd]
                        del message_queues[connection]

        elif event & select.EPOLLOUT:
            try:
                msg = message_queues[socket].get_nowait()
            except Queue.Empty:
                print socket.getpeername(), "queue empty"
                # epoll.modify(fd, select.EPOLLIN | select.EPOLLET)
            else:
                print "send message: ", msg
                print "to client: ", socket.getpeername()
                socket.send(msg)

                epoll.unregister(fd)
                fd_to_socket[fd].close()
                del fd_to_socket[fd]
                del message_queues[connection]

        elif event & select.EPOLLHUP:
            epoll.unregister(fd)
            fd_to_socket[fd].close()
            del fd_to_socket[fd]

epoll.unregister(serversocket.fileno())
epoll.close()
serversocket.close()
