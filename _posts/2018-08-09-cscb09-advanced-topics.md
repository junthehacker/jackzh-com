---
layout: post
title:  "CSCB09 Software Tools and Systems Programming - Advanced Topics"
date:   2018-08-09 10:50:00 -0400
tags: cscb09 coures-notes
category: cscb09
---

This article is mainly notes I have taken for CSCB09/CSC209 at UofT.

<!--more-->

## I/O Multiplexing

We use `select` to achieve I/O multiplexing.

```c
int select(int maxfdp1,
           fd_set *readset,
           fd_set *writeset,
           fd_set *exceptset,
           const struct timeval *timeout);
```

```c
struct timeval {
    long tv_sec;
    long tv_usec;
}
```

Sets are hidden within fd_set type, but usually is just a list of integers.

```c
for(;;) {
    rset = allset;
    nready = select(maxfd+1, &rset, NULL, NULL, NULL);
    if(FD_ISSET(listenfd, &rset)) {
        connfd = accept(listenfd, &caddr, &clen);
        for(i = 0; i < FD_SETSIZE; i++) {
            if(client[i] < 0) {
                client[i] = connfd; break;
            }
        }
        FD_SET(connfd, &allset);
        if(connfd > maxfd) maxfd = connfd;
    }
    for(i = 0; i <= maxi; i++) {
        if(sockfd = client[i]) < 0) continue;
        if(FD_ISSET(sockfd, &rset))
            read(sockfd, line, MAXLINE);
    }
}
```

## Bit Strings

Bitwise operators

```c
<< // left shift
>> // right shift
~ // Not
& // And
^ // Xor
| // Or
```