---
layout: post
title: CSCC69 Operating Systems - Threads
date: 2019-02-13 13:50:00 -0400
tags: cscc69 course-notes
category: cscc69
---

## Overview

Threads are basically mini-processes within a process. However they share the same address space.

Creating threads are much faster than creating processes, in some systems, this can be 10x to 100x faster.

Think of threads as JS event loops, basically it.

## Classic Thread Model

The classic thread model basically have all threads with their own stack and own PC.

Everything else is shared. The software library will take care of scheduling.

## POSIX Thread Standard

Some useful calls:

* pthread_create: New thread
* pthread_exit: Quite the calling thread
* pthread_join: Wait for a thread to exit
* pthread_yield: Give up CPU for another thread
* pthread_attr_init: Create a thread attribute structure
* pthread_attr_destroy: Remove a thread's attribute structure

## User Space Thread Implementation

If implemented in user space, then the library have to take care of scheduling and switching. However if hardware do support store/load registers, this operation can be done very quickly, which is much faster than trapping to kernel.

And since everything is local, no context switch is needed, no kernel calls, it is very fast. Each process can also have its own scheduling algorithm.

### Drawbacks

Thread cannot make blocking kernel calls, since that will halt all threads. Sometimes library will wrap the actual system call, but it is not really that nice to do.

Another issue is page fault. Which will be discussed in memory management (basically blocking the process because it needs to read instructions from disk).

In user space thread implementations, there is no clock interrupts. So a thread must give up the CPU before another thread can be run.

## Kernel Space Thread Implementation

