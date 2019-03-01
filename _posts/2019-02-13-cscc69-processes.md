---
layout: post
title: CSCC69 Operating Systems - Processes
date: 2019-02-13 10:54:00 -0400
tags: cscc69 course-notes
category: cscc69
---

## Overview

Processes allows computers to do multiple things at once.

In multiprogramming system, CPU switches from process to process very quickly, make it seem that it is running them concurrently. This is usually called pseudoparallelism, in contrast to real-parallelism with multiprocessor.

*In any given instant, only one process is running on one CPU.*

> *Context Switch*: a context switch is the process of storing the state of a process or of a thread so that it can be restored and resumed later.

## Drawbacks

* Programs cannot have assumption of timing. Say if you know 1 loop takes 0.01 millisec, you loop 1000 times to get 10 millisec. However, while in the loop, OS might already switched to another process.

## Program vs Process

An analogy:

* Recepe: Program
* Ingredients: Input Data
* Process: Reading the recepe, getting ingredients and baking the cake.

Now the guy's son runs into room and says he has been stung by a bee. The guy records where he was in the recipe, gets first aid book and following that. After first aid has been done, he goes back to cooking. This is basically how OS switches processes.

In real OS this is called scheduling. And if a programming is running twice, it is two processes.

## Process Creation

There are 4 principal events that cause processes to be created:

* System initialization
* Execution of a process creation system call by a running process
* A user request to create a new process
* Initiation of a batch job

There are 2 main types: foreground and background (daemons).

Technically, for all these cases, a new process is created by an existing process. In UNIX, only `fork` can be used to create new processes. After fork, the child may change its memory image using `execve`. Reason is so we can redirect IO before `execve`.

Parent and child have different address space. However they may share text.

## Process Termination

There are 4 ways for a process to terminate.

* Normal exit
* Error exit
* Fatal error
* Killed by another process

## Process Hierarchies

In UNIX, a process and all of its children form a process group. When a user sends a signal from the keyboard, all members are notified.

In UNIX, all processes belong to a single tree, which `init` at the root. Processes cannot change parent (unless parent is killed by some reason).

## Process States

There are 3 main states:

* Running: Actually using the CPU
* Ready: Can run, but temp stopped for another process to run
* Blocked: Cannot run until some external event happens

In UNIX, a process is automatically blocked if trying to read from an empty pipe.

## Process Implementation

People use process table (PCB) to implement processes. Usually a table includes:

* State
* Memory allocation
* Open files
* Scheduling info
* Registers
* etc.

### Interrupt Vector

Usually located at the bottom of the memory, when an interrupt happens, the hardware pushes process info onto stack, and jumps to interrupt vector. Then the interrupt procedure runs.

All interrupts start by saving registers, this is usually done in assembly since C cannot access these information. Then the access is handed over to interrupt handler (stack is also reset).

After the handler is done, the control is back to assembly to load the registers again.

Overview of the basic procedures are listed below:

* Hardware stacks basic program information
* Hardware loads PC from IV.
* Assembly saves registers
* Assembly set up new stack.
* Runs C interrupt service.
* Scheduler decides which to run next.
* C procedure returns to assembly code.
* Assembly runs new process.