---
layout: post
title:  "CSCB09 Software Tools and Systems Programming - Sockets"
date:   2018-08-09 10:49:00 -0400
tags: cscb09 course-notes
category: cscb09
---

This article is mainly notes I have taken for CSCB09/CSC209 at UofT.

<!--more-->

## TCP/IP

* Transmission Control Protocol
* It tells us how to package up the data

![](https://www.evernote.com/l/Aq3pZW8_29dAvrU4mV4d0ZhMT0UF3PBUxXEB/image.png)

### Three-Way Handshake

* Client request connection
* Server return with ack
* Client sends ack
* Server gets ack, connection established

Following graph is the whole process, three-way handshake happends at client connect.

![](https://www.evernote.com/l/Aq27o7vPDAtKEJv7fy233DdwMdE8Bj8C2gAB/image.png)

### TCP Congestion Control

TCP control congestion using two methods:

* Slow-start
    * Connection won't reach full speed right away
* Window-based
    * Some packets are allowed to be sent without ack'd
    * If ack'd, grow window
    * If packet loss, cut window

## Sockets

Another form of communication between processes.

Very similar to pipes, but on different machines, file descriptors are used to refer to sockets, it is an interface between application and network.

### Types of Sockets

There are two main categories

* UNIX domain: Both processes on same machine
* INET domain: on different machines

There three main types

* SOCK_STREAM - TCP Sockets
* SOCK_DGRAM - UDP Sockets
* SOCK_RAW

### Addresses and Ports

Socket pair is the two endpoints of the connection, which is identified by an IP address and a port.

IPv4 are 4 8-bit numbers, ports can range from 0-65535 (2^16)

Port categories:

* Well-known ports: 0-1023
* Registered ports: 1024-49151
* Dynamic ports: 49152-65535

### Server Setup

To start a socket server, use the following function

```c
int socket(int family, int type, int protocol);
```

Family can be `PF_INET` or `PF_LOCAL`.

Type can be `SOCK_STREAM`, `SOCK_DGRAM` or `SOCK_RAW`.

Protocal should be 0 other than RAW.

Returns a socket descriptor, which is just like a file descriptor.

```c
#include<ctype.h>
#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
int main() {
    int sockfd;
    if((sockfd=socket(AF_INET, SOCK_STREAM, 0))==-1){
        perror("socket call failed");
        exit(1);
    }
    //*** bind the server address to the end point,
    listen for connections, accept a connection ***//
}
```

Then we need to bind to a name

```c
int bind(int sockfd, const struct sockaddr *servaddr, socklen_t addrlen);
```

sockfd is the descriptor returned by `socket()`

```c
struct sockaddr_in {
    short sin_family;
    u_short sin_port;
    struct in_addr sin_addr;
    char sin_zero[8];
}
```

`sin_addr` can be set to `INADDR_ANY` to communicate on any network interface.

After binding, we need to setup the queue in kernel.

```c
int listen(int sockfd, int backlog);
```

After listening, socket is ready to accept connections.

`backlog` is the max number of partially completed connections that kernal should queue.

Finally, we can complete the connection.

```c
int accept(int sockfd, struct sockaddr *cliaddr, socklen_t *addrlen);
```

This function will block while waiting for connection.

Returns a new descriptor which refers to the TCP connection for client.

`sockfd` is the listening socket.

`cliaddr` is the client address.

Read / Write on the socket returned.

```c
#include<ctype.h>
#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#define SIZE sizeof(struct sockaddr_in)
int newsockfd;

int main() {
    int sockfd;
    struct sockaddr_in server=(AF_INET, 7000, INADDR_ANY);
    if((sockfd=socket(AF_INET, SOCK_STREAM, 0)) == -1) {
        perror("socket call failed");
        exit(1);
    }
    if(bind(sockfd, (struct sockaddr *)&server, SIZE) == -1) {
        perror("bind call failed");
        exit(1);
    }
    if(listem(sockfd, 5) == -1) {
        perror("listen call failed");
        exit(1);
    }
    for(;;) {
        if((newsockfd=accept(sockfd, NULL, NULL)) == -1) {
            perror("accept call failed");
            exit(1);
        }
    }
}

```

### Client Setup

`socket()` is the same as server.

To establish a connection, use `connect` function

```c
int connect(int socketfd, const struct sockaddr *servaddr, socklen_t addrlen);
```

Kernel will choose a dynamic port and source address.

```c
#include<ctype.h>
#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#define SIZE sizeof(struct sockaddr_in)
int main() {
    int sockfd;
    struct sockaddr_in server = (AF_INET, 7000);
    server.sin_addr.s_addr=inet_addr("206.45.10.2");
    if((sockfd=socket(AF_INET, SOCK_STREAM, 0)) == -1){
        perror("socket call failed");
        exit(1);
    }
    if(connect(sockfd, (struct sockadr *)&server, SIZE) == -1){
        perror("connect call failed"); exit(1);
    }
}
```

### Network Byte Order

Before sending numbers, convert them to network byte order first.

```c
unsigned long htonl(unsigned long)
unsigned short htons(unsigned short)
unsigned long ntohl(unsigned long)
unsigned short ntohs(unsigned short)
```

### Sending and Receiving Data

You can use `read` and `write`, but sometimes if you want more control, you can use `send` and `recv`.

```c
ssize_t send(int fd, const void *buf, size_t len, int flags);
```

Same as `write` if flags is 0, you can use other flags like `MSG_OOB`, `MSG_DONTROUTE`, `MSG_DONTWAIT`.

```c
ssize_t recv(int fd, void *buf, size_t len, int flags);
```

Flags: `MSG_OOB`, `MSG_WAITALL`, `MSG_PEEK`.

After you are finished with the socket, simply call `close(s)`.

