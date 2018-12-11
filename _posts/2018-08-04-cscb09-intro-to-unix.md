---
layout: post
title:  "CSCB09 Software Tools and Systems Programming - Intro to UNIX"
date:   2018-08-04 10:46:00 -0400
tags: cscb09 course-notes
category: cscb09
---

This article is mainly notes I have taken for CSCB09/CSC209 at UofT.

<!--more-->

Who is using Unix/Linux?

* 10% Desktop/Laptops
* 85% Tablets/Smartphones
* 65% Web Servers
* 98% Super Computers

## What is an Operating System

**The software layer between user applications and hardware.**

* Resource manager
* Control program
* Abstractions

One example of abstraction is files and directories. These are concepts defined within an OS.

## File

File is a named collection of data with some attributes

* name
* owner
* size
* permissions
* timestamps
* location on the actual hardware

To get information of a file in Unix, you use the following commands

```
ls -l
stat
```

### UNIX Implementation

Unix uses a data structure called `inode` to store information about a file. It is identified by `inode number`.

```
615 (inode number)
-------------------------
size                    |
owner                   |
timestamps              |
link/block counts       |
permissions             |
-------------------------
pointers to file blocks |
-------------------------
single indirect pointer | -> pointers to next blocks
-------------------------
double indirect pointer |
-------------------------
triple indirect pointer |
-------------------------
```

## Directories

Directories is a collection of files.

In UNIX, every directory is a file.

### UNIX Implementation

Since directories are files, they also uses `inode`. Only special thing is that they contain data called `directory entries`

```
615 (inode number)
-------------------------
size                    |
owner                   |
timestamps              |
link/block counts       |
permissions             |
-------------------------
pointers to file blocks |  -
-------------------------  |
single indirect pointer |  |
-------------------------  |---> Directory entries contians other inode numbers
double indirect pointer |  |
-------------------------  |
triple indirect pointer |  -
-------------------------
```

## Everything is a File

In UNIX, all input / ouput are files.

* regular files
* directories
* devices
    * camera
    * sound
    * network
    * .....

### Directory Hierarchy

Directories are not trees, but an acyclic graph.

For example, graph below is an acyclic graph.

![](https://www.evernote.com/l/Aq1tiBosESpIzamoLrozGN73oy1fq-epOJUB/image.png)

## Links

### Hard Links

To create a hard link, use following command

```
ln <target> <name of link>
```

The link will be identical to target, containing the same inode number. A file will only be removed if there are no more name/hard links.

So even if you remove the original file, the hard link is still valid.

### Soft Links

To create a soft link, use following command

```
ln -s <target> <name of link>
```

This will create a small file containing the true path of the linked file. Soft link will have different inode number. Think of it as a bookmark.

If you remove target, soft link will become invalid.

## Permissions

Permissions in UNIX is very simple. When you run `ls -l`, you should see the following output:
```
drwx------@  8 junzheng  staff   256 19 Jul 04:20 Applications
drwxr-xr-x   3 junzheng  staff    96 31 May 13:24 CLionProjects
drwxrwxr-x@ 26 junzheng  staff   832 28 Jul 20:54 Creative Cloud Files
drwx------@ 15 junzheng  staff   480  2 Aug 21:33 Desktop
```

`rwxr-xr-x` is the corresponding permissions for the file. It is structured like following

```
User   Group    Other
rwx    r-x      r-x
```

Each entry have three permissions:
* read
* write
* execute

Directory permissions is similar to files, with `d` prefix.

* read - You can `ls` directory
* write - You can create and remove files in directory
* execute - You can cd into the directory

### Modify Permissions

To modify permissions, use `chmod`.

For example, following command will give owning user execute permission
```
chmod u+x file_name
```


## Shell

Shell is simply a commandline interpreter, it is the interface between user and OS.

There are many shells to choose from:

* `sh` - Bourne shell
    * Most common
    * Good for programming
* `csh` or `tcsh`
    * C-like syntax
* `bash` - Bourne again shell
    * Based on `sh` with some `csh` features
* `korn` - Commercial

We usually use `bash`, it is a superset of `sh`.

### Input and Output Redirection

By default, programs read from stdin and write to stdout. They also write errors to stderr.

However, you can change input/output/err.

* `> file` redirect output to file
* `>> file` appends output to file
* `< file` redirects input

1 is stdout, 2 is stderr. You can redirect stderr using `2> file`.

### Pipelines

Use `|` to redirect the output of a command to input of another command.

For example:

```
ls -l | wc -l
```

Will count the lines printed by `ls -l` command.

### Filters

Filters are programs, that reads from stdin, and outputs filtered result.

There are many to choose from 

* `wc` - Count words, lines etc.
* `grep` - Filter by pattern
* `uniq` - Remove repeating lines
* `sort` - Sorts the input
* `head` - Get first lines
* `tail` - Get last lines
* `sed` - Text transformations

### Job Control

Use `ps` to view processes. There are two main types of processes:

* Forground: has control of terminal
* Background: runs concurrently with shell in background

To run a command in background, append & to the name.

You can hit `ctrl+z` to suspend forground job.

* `jobs` will show a list of running jobs.
* `fg <id>` will put `id` in foreground.
* `bg <id>` will put `id` in background.
* `kill %<id>` will kill job `id`.

**Jobs are different from processes!**