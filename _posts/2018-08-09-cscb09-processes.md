---
layout: post
title:  "CSCB09 Software Tools and Systems Programming - Processes"
date:   2018-08-09 10:47:00 -0400
categories: cscb09
tags: cscb09 course-notes
---

This article is mainly notes I have taken for CSCB09/CSC209 at UofT.

<!--more-->

## fork

A fork system call will create a child process that is a duplicate of the parent.

`fork()` takes no arguments and returns a process ID.

To use fork, include `unistd.h`.

The return value of fork is different depends on the outcome:

* On success
    * Return 0 if it is within child
    * Return child's PID if it is within parent
* On failure
    * Return -1 to parent

Fork with loop example:

```c
int main() {
    int i;
    pid_t child;
    for(i = 0; i < 3; i++) {
        child = fork();
        if (child == 0)
            printf("Child %d", getpid());
    }
    return 0;
}
```

This program will have 8 processes in total, including the parent process.

## wait

Within parent process, you might want to wait for a child to terminate. You might also want to know the exit code for a child.

You can use `wait()` for that. It will block until one of the children terminates or there is no more child.

```c
pid_t wait(int *status);
```

It returns the PID of the child, and sets the `status` as the child's exit status.

### Some Macros

* `WIFEXITED` - If child terminated normally
* `WEXITSTATUS` - Gives you the status

```c
wait(&status);
if(WIFEXITED(status)) {
    // Exited normally
}
```

## Zombie Processes

When a child terminates, but its parent process is not waiting for it.

Then the child is kept around as a zombie until the parent collects its status using `wait`.

It will show up as `Z` in `ps`.

## Orphan Processes

If a parent terminates before the child, child becomes a orphan.

Orphans gets adopted by `init` process, which has PID of 1.

## waitpid

If you want to wait for a specific child, use waitpid

```c
pid_t waitpid(pid_t pid, int *status, int options);
```

If options is 0, it will block, just like wait.

However if it is WNOHANG, it will return 0, without blocking, you have to keep calling it to check.

## exec

Exec will *replace* the program being run by a different one.

```c
int i = 5;
printf("%d\n", i);
exec("Y");
printf("%d\n", i);
```

The last line of the above program will NEVER run, unless there is an error.

Exec is a family of functions

```c
execl(char *path, char *arg0, …, (char *)NULL);
execv(char *path, char *argv[]);
execlp(char *file, char *arg0, …,(char *)NULL);
execvp(char *file, char *argv[]);
```

### Shell Skeleton

```c
while(1){
    print_prompt();
    read_cmd(command, params);
    if(fork()){
        wait(&status);
    } else {
        // Exec
    }
}
```

## File Descriptors

FDs are handles to open files, they belong to processes.

FDs are preserved across fork and exec.

## Initializing UNIX

The only way to create new process is to fork, and only way to run new program is exec.

Therefore all processes have ancestor of pid 1.

