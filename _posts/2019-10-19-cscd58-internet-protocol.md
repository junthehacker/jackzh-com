---
layout: post
title: CSCD58 Computer Networks - Internet Protocol
date: 2019-10-18 13:18:00 -0400
tags: cscd58 course-notes
category: cscd58
---

Introduction to ethernet and IP

<!--more-->

## Ethernet (Data Link Layer)

Dominant wired LAN tech, first widely used as well.

Simpler and cheaper than token LANs and ATM. Pretty fast as well.

### CSMA/CD

Carrier sense multiple access
* Wait until channel is idle to start transmission

Collision detection
* Listen while transmitting, if there is a colltion, then abort and send jam signal

Usually ethernet do exponential back-off, if there was a collision, it waits for a random time before trying again.
* After mth collision, chookse K randomly from {0, ...., 2^m-1}
* and wait for k*512 bit times.

### Limitation on Length

Suppose the latency on a network is `d`. And host A sends a packet to B, B will not see that packet until t+d, if a collision happens, then the earliest time A can know is t+2d.

This imposes some restriction on ethernet:
* Maximum length of the wire 2500m
* Minimum length of the packet 512 bits

### Frame Structure

* Addresses: Source and destination MAC addresses
    * If destination address matches the adaptor, then all good, otherwise drop.
* Type: Indicates higher layer protocol
    * Usually IP
* CRC: Error checking bits

![](https://www.evernote.com/l/Aq0xupKW_spOgq5Qa9lLak8WWp-qf0s_rr4B/image.png)

## Connectionless Service

### Connectionless
* No handshaking

### Unreliable
* Receiving adapter doesn't send ACKs or NACKs
* Packets can have gaps
* TCP will fill the gaps, otherwise the application will see them

## Switching Data

Different device switch different things
* Physical layer: electrical signals
* Link layer: frames
* Network layer: packets

### Repeaters (Physical)

It basically monitors electrical signals on each LAN, and transmits an amplified copy. Used to increase network distance.

### Hubs (Physical)

Joins multiple input lines, can hold multiple line cards. Doesn't necessarily amplify the signal, but I don't see why not.

However, repeaters and hubs have problems

* Huge collision domain
* Cannot support multiple technologies
* Still have limitations (still can't go beyond 2500 meters on ethernet)
    * basically.. you are still in the same LAN!

### Bridges (Link)

Connects two or more LANs at the link layer.
* Extracts destination address from the frame
* Looks up destination in its own table
* Forwards the frame

### Switches (Link)

Basically bridges, but instead of connecting LANs it connects hosts.

### Dedicated Access and Full Duplex

* Dedicated access
    * Direct connection with the switch
* Full duplex
    * Connection can go both directions
    * So no more collision issue

### Hubs vs Switches

#### Advantages
* Only forwards frames to the correct host
* Can extend the geographic span of the network
* Improves privacy
* Applies CSMA/CD
* Can have different technologies

#### Disadvantages
* Slower
    * Solution is cut-through switching
* Need to learn where to forward frames
* Higher cost

### Cut-Through Switching

Buffering a frame takes time, and the delay can be quite large compared to network delays.

Basically two main points
* Start transmitting as soon as possible
* Transmit the head of the packet while still receiving the tail (because head already tells you where to forward)

### Self Learning

We want to construct the switch table automatically.

When a packet arrives, switch inpects the MAC address and associates that MAC with the incoming interface. Now the switch knows how to reach that host.

If the switch doesn't know where to send the packet, then it will just flood the network (send to every host).

#### Flooding and Loops

Switches sometimes needs to broadcast frames. Which just means flooding.

Flooding can lead to loops if there is a cycle of switches.

#### Spanning Trees

A spanning tree makes sure the topology has no loops, switches needs to cooperate to build the spanning tree.

The basic idea:
* Elect a root (switch with smallest identifier)
* Each switch checks if its interface is on the shortest path from the root
    * Excludes it from the tree if not

The algorithm:
* Initially, each switch thinks it is the root
    * Sends out a message to every interface identifying itself as the root with distance of 0
* Upon receiving a message
    * Check root id, if smaller
    * Start viewing that switch as root
* Adds 1 to the distance received from a neighbor
    * Checks to see which interface is not on a shortest path to root
    * Exclude them

However algorithms can fail, here are some important things to note:

* Failure of the root node
    * Must elect a new root
* Failure of other switches
    * Must recompute
* Root switch should periodically reannouncing itself as the root
* Detecting failure through timeout
    * Wait to hear from others
    * If takes too long, just claims itself to be root

### Switches vs Routers

#### Advantages

* Plug and play
* Fast filtering and forwarding


#### Disadvantages
* Topology is restricted to spanning tree
* Large networks require large ARP (address resolution protocol) tables
* Broadcast storms can cause the network to collapse

![](https://www.evernote.com/l/Aq1fMD0eDtlNAY3rRYYncgP2CCNMdVpTMXEB/image.png)

## The Internet Protocol (IP)

* Connectionless
* Unreliable
* Best effort
* Uses datagram

![](https://www.evernote.com/l/Aq0FEwPq2T5LaLDipyBS3DqEY2w8Ub4t-PcB/image.png)

### Fragmentation

A router may receive a packet larger than the maximum MTU of the outgoing link.

Then it must seperate the datagram into multiple smaller ones.

* Fragments are re-assembled by destination host, not intermediate routers.
* Usually we use path MTU discovery to find the smallest MTU along the path.

### IP Addresses

IPv4 are 32 bits long, every interface has a unique IP address. IPv6 are 128 bits long.

IP addresses maybe assigned statically or dynamically (DHCP).

#### Classes

Originally there were 5 classes

* A: Starts with `0`, 7 bit ID
* B: Starts with `10`, 14 bit ID
* C: Starts with `110`, 21 bit ID
* D: Starts with `1110`, 28 bit multicast group ID
* E: Starts with `11110`, 27 bit reserved

But this leads to many problems

* Address classes are too "regid", A is too large, B is too small.
* Internally might need a seperate network ID for each link.
* Then the public needs to know them as well, very inefficient.
* Small organizations wanted class B, but there are only 16,000 class B network IDs.

There are two main solutions

#### Subnetting

Subdivide the organization's network ID

Basically you go over your net ID and use first few bits of the host ID to divide up the network.

Subnets are usually represented via an address plus a subet mask. `ffffff00` if first 24 bits are the subnet ID, last 8 bits are the host ID.

#### Classless Inter-Domain Routing (CIDR)

IP space is broken into line segments.

128.9.0.0/16 basically means the line segment containing addresses in teh range 128.9.0.0 - 128.9.255.255.

Longer the prefix, smaller the network, thus more specific.

Sometimes if an ISP serves two organizations with similar prefixes, it can sometimes aggregate them to form a shorter prefix, so other routers can have smaller tables.

In principle, an organization can keep its prefix if it changes service providers.

#### IPv6

128 bits, it uses 8 groups of 4 hex digits.

Omit leading zeros and groups of zeros.

so `2001:0db8:0000:0000:0000:ff00:0042:8329` is basically `2001:0db8::ff00:0042:8329`

### IPv6 Transition

How do we deploy IPv6? It is fundamentally incompatible with IPv4.

There are many approaches

* Dual stack (both v4 and v6)
* Translators (converts packets)
* Tunnels (carrys IPv6 over IPv4)

#### Tunneling

Basically, tunnel carries IPv6 packets across IPv4 network.

![](https://www.evernote.com/l/Aq0Zh9eH4CtMSqfFsiBHJhGI5WQIXhusb-8B/image.png)

However it is hard to setup tunnel endpoints and routing.

## DNS

Names are hierarchical and belong to a domain. Top-level domains are assigned by the Internet Corporation of Assigned Names and Numbers (ICANN).

### DNS Query

* Client asks local server
* If local doesn't have address, asks the root server of the requested domain
* Addresses are usually cached

### ICMP (Internet Control Message Protocol)

Used by hosts and routers to communicate network-level information.

ICMP is carried in IP datagrams.

It includes type, code plus first 8 bytes of IP datagram causing error.

### Traceroute

The source sends series of UDP segments to destination
* TTL = 1,2,3...

When datagram in nth set arrives to nth router, the router discards datagram and sends source an ICMP message of type 11, code 0, also includes name and IP.

When ICMP arrives, source records RTT.

It will eventually arrive at destination host. Destination will return ICMP port unreachable (type 3, code 3), then source stops.

