---
layout: post
title:  "CSCB09 Software Tools and Systems Programming - Signals and Sockets"
date:   2018-08-09 10:49:00 -0400
tags: cscb09 course-notes
category: cscb09
---

This article is mainly notes I have taken for CSCB09/CSC209 at UofT.

<!--more-->

## Signals

Signals is another form of IPC, signals can be sent at anytime, they are asynchronous events.

Events are called interrupts.

### Signal Types

You can send signals from shell, for example:

* SIGINT - Ctrl+C
* SIGSTEP - Ctrl+Z

You can find a list of interrupts from `sys/signal.h`.

### Signal Handlers

When C program receives a signal, control is passed to a function called a signal handler. It can execute some C statements, and can exit in 3 ways:

* Return control to the point where signal is received.
* Return control to some other point within the program.
* Exit the program

### Catching a Signal

```c
#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <stdlib.h>

void sig_handler(int signo) {
        if(signo == SIGINT)
                printf("Received SIGINT\n");
        if(signo == SIGFPE) {
                printf("You cannot divide by zero\n");
                exit(SIGFPE);
        }
}

int main() {
        if(signal(SIGINT, sig_handler) == SIG_ERR)
                printf("Unable to catch SIGINT\n");
        if(signal(SIGFPE, sig_handler) == SIG_ERR)
                printf("Unable to catch SIGFPE\n");
        int i;
        for(i=-3; i <= 3; i++) {
                printf("%d\n", 12/i);
                sleep(5000);
        }
        while(1)
                sleep(1);
        return 0;
}
```

### Ignore a Signal

To ignore a signal, use `SIG_IGN`

```c
signal(SIGINT, SIG_IGN); // This will ignore all SIGINT.
```

### Use Default Action

To use a default action for a signal, use `SIG_DFL`

```c
signal(SIGINT, SIG_DFL); // Terminate upon SIGINT.
```

## Signal Table

For each process, UNIX maintains a table of actions for each signal. Most of them you can change the action, exceptions are SIGKILL and SIGSTOP.

### sigaction

```c
int sigaction(int sig, const struct sigaction *act, struct sigaction *oldact);
```

`sigaction` function will install a signal handler `act`.

It will also populate `oldact` with the old handler.

```c
struct sigaction {
    void (*sa_handler)(int);
    sigset_t sa_mask;
    int sa_flags;
}
```

When a new signal is receeived when a handler is running, then the first signal handler is suspended and the newly invoked handler will run.

> This only applies to different signals.

## Block Signals

Signals can arrive at anytime, we can block signals using masks.

To block signals within `act`

```c
newact.sa_handler = hand;
newact.sa_flags = 0;
// We block all SIGTERMS
sigaddset(&newact.sa_mask, SIGTERM);
if(sigaction(SIGINT, &newact, NULL) == -1) exit(1);
if(sigaction(SIGTERM, &newact, NULL) == -1) exit(1);
```

Above code will block SIGTERM when hand is running.

You can also use `sigprocmask` to directly block signals within the program

```c
int sigprocmask(int how, const sigset_t *set, sigset_t *oset);
```

`oset` is the old set of blocked signals, you can use it to reset blocked signals later.

```c
sigset_t newmask, oldmask;
sigemptyset(&newmask);
sigaddset(&newmask, SIGINT);
//block SIGINT and save oldmask
sigprocmask(SIG_BLOCK, &newmask, &oldmask);
/*critical section of the code*/
//reset mask which unblocks SIGINT
sigprocmask(SIG_SETMASK, &oldmask, NULL); 
```


## Sending Signals

You can send signals to different processes using `kill` function

```c
kill(int pid, int sig);
```

## Timer Signals

Three timers are maintained for each process:

* SIGALRM
* SIGVTALRM
* SIGPROF

You can use following functions to do stuff with timers

```
sleep(), usleep(), alarm(), pause(), setitimer(), getitimer()
```

sleep() and usleep() can be interrupted by other signals.