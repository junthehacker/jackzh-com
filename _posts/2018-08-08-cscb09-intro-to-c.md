---
layout: post
title:  CSCB09 Software Tools and Systems Programming - Intro to C
tags: cscb09 course-notes
category: cscb09
---

This article is mainly notes I have taken for CSCB09/CSC209 at UofT.

<!--more-->

## Why C?

C is extremely powerful, in some sense, it is much powerful than any other modern programming language.

Everything you use today is mostly written in C.

### C-Based Languages

* `C++`, has all features of C, but adds OOP support.
* `Java`, is based on C++.
* `C#`, is derived from C++ and Java.
* `Perl`, has adopted many features of C.

## First Program

```c
#include <stdio.h>

int gcd (int x, int y);

int main() {
    int i;
    for(i = 0; i < 20; i++) {
        printf("gcd of 12 and %d is %d\n", i, gcd(12, i));
    }
    return 0;
}

int gcd(int x, int y) {
    int t;
    while (y) {
        t = x;
        x = y;
        y = t % y;
    }
    return x;
}
```

## Functions

Every C program needs a function called `main()`, returns `int`, which is the exit status.

All functions must be declared before first use (header files), and defined.

`#include` are used to import external functions.

## Control Structures

Same as any other language, `for`, `while` and `if`. Won't go in detail here.

## Variables

All variables must be declared, and have no default value.

Variables are only visible within the block they are declared in, if you wish to declare global variable, declare it outside of `main()`.

All variables are local.

### Data Types

Basic data types

**Integers**
* char
* int
* long

**Real Numbers**
* float
* double

**Remember, `char` is a integer.**. There are also arrays, pointers and structs.

## Compile

To compile a C program, use the following command

```bash
gcc -Wall -o gcd gcd.c
```

## Memory Model

Memory for a process is called it's address space, it is just a sequence of bytes.

A location (byte) is identified by an address.

This is how a program's memory is structured.

![](https://www.evernote.com/l/Aq0AJX3WD_NLLahrjoicZYX5z1LSpbfWpHAB/image.png)

Stack will grow up as we call functions, heap will grow down as we allocate dynamic memories.

If they collide, you may get a stack overflow error, which basically means you ran out of memory to use.

Example:

```c
int x = 10;
int y;
int f(int p, int q) {
    int j = 5;
    return p * q + j;
}
int main() {
    int i = x;
    y = f(i, i);
    return 0;
}
```

Above program will have x, y in static space, i, p, q, j in stack.

Once a function finishes, *the variable in stack is freed automatically.* To keep a variable alive, you have to use heap, or dynamic memory space.

## Arrays

Arrays in C are basically just a chunk of memory that contains a list of items of the same type.

You cannot determine the array size, C will also not care if you accessed index that is out of bound.

To define an array, use the following syntax

```c
int x[5];
```

There is no runtime checking, so you can do this:

```c
x[100] = 10;
```

It might work, it might crash, or do something random.

### Initialization

To declare an array, just do `int x[5]`, it will create a 5 element arrary that contains integers.

You can use a for loop to initialize an array, or use static initializaiton

```c
int x[5] = {1, 3, 4, 1, 2};
```

## Pointers

Pointer is a higher-level version of an address, to declare a pointer:

```c
char *cptr; // Create a pointer to char
```

To assign a value to pointer

```c
char c = 'a';
cptr = &c;
```

To dereference a pointer

```c
*cptr = 'b';
char d = *cptr;
```

When you do `int *p`, memory is only allocated to store the pointer, to make it useful, you still need memory for an actual int.

For example

```c
int *p;
*p = 10; // This is not valid
```

### Arrays vs Pointers

Array's name in expression context will decay into a pointer to 0th element.

But they are different things.

```c
int a[3];
int *p = a; // Same as p = &a[0]
```

### Pointer Arithmetic

You can do arithmetic on pointers, to jump to a specific memory location.

For example

```c
a[i]; // Is same as...
*(a + i);
```

Pointer arithmetic respects the type, so you don't have to worry about how many bytes to add.

## Array as Parameter

There are two syntaxes you can use:

```c
int f(int *a, int size)
int f(int a[], int size)
```

Second one is not advised to use, since you are really just passing a pointer.

## Multi-Dimensional Arrays

You can also have multi-dimensional arrays in C, use the following syntax:

```c
int a[3][3];
```

C stores array in row-major order, therefore `a[i][j]` is the same as `*(x + i * n +j)` where `n` is the row size of `a`.