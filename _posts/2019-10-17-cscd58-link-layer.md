---
layout: post
title: CSCD58 Computer Networks - Link Layer
date: 2019-10-17 20:22:00 -0400
tags: cscd58 course-notes
category: cscd58
---

## Introduction

How do we send messages across a wire?

Hosts and routers are called *nodes*, and the communication path are called *links*. A frame encapsulates the datagram and sends the data through a link.

```
Application
Presentation
Session
Transport
Network
Data Link       <- Network cards etc.
Physical        <- Ethernet cables, wireless signals
```

The *data link* layer is responsible for transferring datagram from one node to physically adjacent node over a physical link.

A datagram maybe transferred to final destination using many different links, and they may have different protocols. *Routing algorithm* decides which path to take to get the datagram to final destination.

## Common Link Layer Services

*Note: link layers may provide more services, these are just examples.*

### Framing

Encapsulate datagram into frames, adding header, trailer (for example addresses and error-correction bits).

### Link Access

Allows upper layers to access links, channel if shared medium.

MAC (Media Access Control) address is used to identify source, destination. This address uniquely identifies each device on a network.

### Reliable Delivery

Usually error correction is not implemented on low error links (fiber, some twisted pairs).

But wireless has high error-rate, so error correction is implemented on link layer.

## Common Physical Media

### Twisted Pairs

Usually max 100m.

CAT5 (most common), supports up to Gigabit ethernet.

CAT6, 6a, 7 can support 10Gbps, 40Gbps, 100Gbps.

### Coaxial Cable

Usually max 200m.

But very slow, usually just 10Mbps (why would anyone use this???).

### Fibre Optic Cables

#### Single-Mode

Very narrow core. 10um, light can't even bounce around within the core.

Used with lasers for long distances (100km).

#### Multi-Mode

Light can bounce within the core (50um). Used with LEDs for shorter distances, cannot go longer because modal dispersion.

### Fiber

Long, thin, pure strand of glass.

Light propogated through internal reflection, huge bandwidth, can reach 100 petabits/kilometer/sec (Bell Labs).

### Wireless

Different frequencies have different properties, and are subject to environmental effects.

* Signals decrease as it propogates through matter.
* Other sources can interfere (for example 2.4Ghz, worst garbage ever).
* Multipath propogation, signal reflects off objects, so they can arrive at destination at slightly different times.

## Bandwidth of a Channel

There are two main definitions of bandwidths:

* B, in Hz, is the width of the pass-band in the frequency domain
* bps, is the information carrying capacity of the channel

They are related to noise, noise limits how many signal levels can we safely distinguish.

## Encoding Bits

Generate analog waveform from transmitter and sample at receiver.

Signal transition rate = Baud rate / Versus bit rate

### NRZ

Simplest encoding, Non-Return to Zero. High = 1, Low = 0.

### NRZI

Transition for 1s, no transition for 0s.

![](https://i.imgur.com/zAXrdUb.png)

## Clock Recovery

How can we distinguish consecutive 0s or 1s?

Sender and receivers won't always have the same clock

There are a few solutions to this problem:

* Send a seperate clock signal -> Expensive
* Keep messages short -> Limits data rate
* Embed clock signal in data signal

### Manchester Coding

Make transition in the middle of every bit period.

* Low-to-High is 0, High-to-Low is 1.
* Used in 10Mbps ethernet.

It is self-clocking, XOR of NRZ encoding. However it has 50% efficiency.

### 4B/5B Codes

Maps 4 bits to 5 bits, and ensures never 3 consecutive 0s back-to-back. 80% efficiency.

Used in LANs (FDDI, 100Mbps ethernet).

## Framing

We need to send messages, not bits (requires synchronization). Adaptors allows hosts to exchange frames through links.

### PPP Point-to-Point Protocol

Flag is `0x7E`, it indicate the start and end of of frames.

If payload contains this flag, it must be "stuffed" (escaped).

* 0x7E -> 0x7D, 0x5E
* 0x7D -> 0x7D, 0x5D

## Latency

How long does it take to send a message.

* Propagation delay = distance / speed of light in media
    * How long does it take for 1 bit to travel.
* Transmission delay = message size / rate
    * How quickly can you get the message onto the wire.

Latency = Propogation Delay + Transmission Delay

![](https://i.imgur.com/jISgrP1.png)

RTT (Round-Trip-Time) is just twice the one way delay.

## Throughput

Measure of system's ability to pumpout data (not bandwidth).

Throughput = Transfer Size / Transfer Time.

## Bandwidth Delay Product

This indicates how many bits can the network "store" in any given time.

Suppose latency is 16 seconds, and the bandwidth is 1b/s, then the BDP is 1b/s * 16s = 16 bits.

Tells us how much data can be sent before a receiver sees any of it. 2x BDP means how much data we could send before hearing back about the first bit. Rule of thumb for sizing router buffers.

## Packet Switching

End to end latency is latency of all routers added together.

Packet switching allows parallel transmission across all links, reducing latendy while also prevents a link from being "hogged" for a long time by one message. This is essentially the exact same idea as memory paging.

### Queueing Delay

Network might be busy when a packet arrives, so the actual end to end latency is

Transmission Delay + Propogation Delay + Queueing Delay

## Error Detection and Correction

Link may transmit garbage, how can we detect errors when it arrives?

This is the responsibility of multiple layers:

* Transport
* Network
* Data Link

Physical is not included because ofc, physical is what causes error.

We can add redundant data

* Error detection codes: Allows errors to be recognized
* Error correction codes: Allows errors to be repaired

Basic block codes????? page 42

### Strategies to Correct Errors

There are two main strategies

* Detect and retransmit, or Automatic Repeat Request (ARQ)
* Use error correcting codes, or Forward Error Correction (FEC)

Real-time media tend to use error correction because it is faster.

Higher levels (network+) may use retransmissions (less error, doesn't make sense to include codes).

Most data networks today use error detection, not correction, because less overhead. But really depends on the application and error characteristics.

#### Common Correction Codes
* Hamming Codes
* Binary Convolutional Codes
* Reed-Solomon and Low-Density Parity Check Codes
    * Complex, but widely used

#### Common Detection Codes
* Parity
* Checksums
* Cyclic redundancy codes

### The Hamming Distance

If an error turns one valid codeword into another valid one, then we cannot detect/correct them.

Hamming distance of a code is the smallest number of bit differences that turn any one codeword into another.

So for example 000/111 has HD of 3.

If we define our error detection code as a simple duplication, then the HD is 2 because all valid words must have at least 2 bits different.

* HD d+1
    * d errors can be detected
* HD 2d+1
    * d errors can be corrected

### Parity

Start with n bits and add another so that total number of 1s is even (even parity).

Cannot detect even number of bit errors. Pretty bad, don't use this garbage.

Random errors are detected with probability of 1/2.

#### 2D Parity

Make the message a grid of bits, and add parity bits to each row and column.

n-D parity can usually correct n-1 errors.

2D parity detects all 1,2,3 bit errors, and many with >3 bits.

![](https://www.evernote.com/l/Aq2gGg1AeyBPrbWI1-XhWweMYrvIZ9ESY9sB/image.png)

### Checksums

Widely used in IP, ICMP, TCP, UDP.

Checksum is the 1s complement of the 1s complement sum of the data interpreted 16 bits at a time (for 16-bit checksums).

Example: 4-bit checksum

Say we have the message 101101111010, first we divide it up to 4 bits segments

```
1011
0111
1010
```

and then we add them
```
  1011
+ 0111
  0010  with 1 carry
  0011
+ 1010
  1101
```

Then the 1s complement of 1101, which is 0010 is our checksum.

On the receiver, we just add all of them

1011 + 0111 + 1010 + 0010 = 1111, we are all good!

### CRCs (Cyclic Redundancy Check)

Stronger then checksums, widely used in ethernet

Given n bits of data, generate a k bit check sequence that gives a combined n + k bits that are divisible by a chosen divisor C(x).

If we have 1001, interpret it as x^3 + x^0

Following example uses message 10011010 and generator 1101 or x^3 + x^2 + x^0

![](https://www.evernote.com/l/Aq3s-J8p2TBPpL1-4c8CnMaf0NRk-otyz3gB/image.png)

Message to be sent is 10011010101, and it is divisible by 1101.

### Reed-Solomon / BCH Codes

Mainly used for magnetic disks.

2t redundant bits can correct <= t errors.
