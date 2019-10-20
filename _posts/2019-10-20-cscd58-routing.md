---
layout: post
title: CSCD58 Computer Networks - Routing
date: 2019-10-20 10:26:00 -0400
tags: cscd58 course-notes
category: cscd58
---

Routers

<!--more-->

## Introduction

With routers, computer network do hop-by-hop packet forwarding.

Which means each router has a forwarding table that maps destination addresses to outgoing interfaces. And upon receiving a packet, it checks the table and sends out the packet. Next router in the path repeats.

## Forwarding

### Forwarding in IP Router

* Lookup packet destination address in table.
    * If unknown, drop the packet
* Decrement TTL, update header checksum
* Forward packet to outgoing interface
* Transmit packet onto link

There are many ways to construct the forwarding table.

### Seperate Table Entries Per Address

Matches destination address of incoming packet to the forwarding table entry, and it should always points directly to an interface.

But this can lead to very large tables.

### Seperate Entry Class-Based Address

We can easily identify the mask from the address

* `0`, class A /8
* `10`, class B /16
* `110`, class C /24

We can then just look in the forwarding table for matches.

For example 1.2.3.4 matches to 1.2.3.0/8, then we lookup for 1.0.0.0/8

### Longest Prefix Match Forwarding

With CIDR, an address can match multiple masks. Usually inside IP router, we map each IP prefix to next-hop links.

We always do the logest match, for example 1.2.3.4 would match both 1.2.0.0/16 and 1.2.3.0/24, in this case we always match /24.

#### Linear Algorithm

We can simply scan each entry and see if address matches, however this is way too slow. With 10Gbps network and 40B packet, we need 31.25 Mpps performance!

#### Fast Lookups

There are algorithms that is faster, but we can also use hardware

Content Addressable Memories is one of them, it allows very fast lookups on a key.

### Other Technologies

Routers have forwarding tables, and you can manually configure each entry.

However it doesn't adapt to failures, new equipment and the need to balance load etc.

That is where routing protocols, DHCP and ARP comes in.

## Routing Techniques

How do we choose the shortest and fastest path?

Forwarding simply forwards a data packet to an outgoing link, but routing is much more complex, routers have to talk to each other to compute the path.

### Why Optimize Routing

End-to-End Performance
* Quality of the path affects user performance
* Delays, throughputs and packet losses

Use of network resources
* You prob don't want to route through a jammed route

Transient disruptions during changes
* Allows us to route through other routes when changes happen

### Naive Approach (Flood)

Just send packets to all ports.

It is pretty inefficient, and has the problem with spanning tree again.

### Distance Vector Distributed Bellman-Ford Algorithm

Define distances at each node x such that d_x(y) is the cost of least-cost path from x to y.

d_x(y) = min{c(x,v) = d_v(y)} over all neighbors v.

Essentially, node x maintains costs of direct links from x to v.

Node x also maintains the distance vector from x to y, which is an estimate of least cost.

Node x maintains its neighbors' distance vectors to y.

Each node v periodically sends its own distance vector x to y to its neighbors, ad neighbors updates their estimate.

Overtime the distance vector will converge.

#### Properties

* Iterative, asynchronous, each local iteration is caused by
    * Local link cost change
    * Distnace vector update message from neighbor
* Distributed
    * Each node notifies neighbors only when its DV changes
    * Neighbors then notify their neighbors if necessary

But have couting to infinity problem.
**TODO: Have to double check this**


### Link State (Dijkstra)

Routers send out update messages whenever the state of an incident link changes.

Based on all link state updates, each router calculates lowest cost path to all others.

It will eventually find a spanning tree rooted at the router.

![](https://www.evernote.com/l/Aq1WjntGw9dOao0VmDCmKiEyd0KJ10GKRSIB/image.png)

#### How do we flood LSP?

LSP = Link State Packet

* It includes the ID of the router that created the LSP
* List of directly connected neighbors and cost
* Sequence number
* TTL

To reliable flood the LSP we resend LSP over all links other than the incident link, if the sequence number is newer. Otherwise drop it.

### LS vs DV

* LS = Link State
* DV = Distance Vector

LS have more messages sent, DV only exchanges between neighbors.

LS requires O(nE) messages and a O(n^2) algorithm. DV is usually slower tho, also have counting to infinity issue.

LS advertise incorrect link cost, each node then simply update its own table.

DV advertises incorrect path cost, which means error propogates, and might be slow to recover.