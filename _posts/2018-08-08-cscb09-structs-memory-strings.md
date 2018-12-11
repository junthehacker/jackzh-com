---
layout: post
title:  "CSCB09 Software Tools and Systems Programming - Structs, Memory, Strings"
date:   2018-08-08 10:46:00 -0400
tags: cscb09 course-notes
categories: cscb09
---

This article is mainly notes I have taken for CSCB09/CSC209 at UofT.

<!--more-->

## Strings

In C, strings are not a built-in data type. It is basically an array of characters terminated with a null character `\0`.

To initialize a string, you use the following code:

```c
char name[4] = {'j', 'u', 'n', '\0'};
// or
char name[4] = "jun";
```

### Operations

A lot of common string operations can be found within `string.h`.

To find the length of a string, use following code:

```c
int length = strlen(your_string);
```

To copy a string, you can use two functions

```c
char *strcpy(char *dest, char *src);
char *strncpy(char *dest, const char *src, int n); // Copy most n characters
```

Usually if we are not sure about the source size, we would use `strncpy` to make sure we never overflow. The correct usage is like the following

```c
strncpy(s1, s2, sizeof(s1) - 1);
s1[sizeof(s1) - 1] = '\0';
```

To concatenating a string, there are also two functions

```c
char *strcat(char *dest, const char *src);
char *strncat(char *dest, const char *src, int n); // Concat most n characters 
```

We usually use `strncat`, the correct usage is following

```c
strncat(s1, "test", sizeof(s1) - strlen(s1) - 1);
// Don't have to pad \0, since strncat will pad \0 for us.
```

To compare two strings, you can use the following functions

```c
int strcmp(const char *s1, const char *s2);
int strncmp(const char *s1, const char *s2, int n); // Compares most n characters
```

`strcmp` is safe, so you can use any of the above.

If the return value is 0, then strings are equal, if <0, first unmatch has less value, if >0, first unmatch has greater value.

To search for a character within the string, use following functions

```c
char *strchr(const char *s, int c); // First 
char *strrchar(const char *s, int c); // Last
```

## Dynamic Memory

There are many reasons for us to use dynamic memory, for example:

* We don't know the data size
* Need a bigger array later
* We need to keep a variable from function

Within our memory model, dynamic data (heap) will never be auto released by the system (unless the program terminated).

### malloc

To allocate memory, we use a function called `malloc()`.

```c
void *malloc(size_t size);
```

It will return a pointer to the newly allocated memory, or `NULL` upon failure.

For example

```c
char *p;
p = malloc(3);
if(p == NULL) // Error
```

We can use `malloc()` to create a `concat` function that concat two strings.

```c
char *concat(const char *s1, const char *s2) {
    char *result;
    result = malloc(strlen(s1) + strlen(s2) + 1);
    if (result == NULL) {
        exit(EXIT_FAILURE);
    }
    strcpy(result, s1);
    strcat(result, s2);
    return result;
}
```

Memory allocated using `malloc` must be manually freed, use `free(p)` to free the memory.

### Memory Leak

Memory can leak when you lost access to a block of dynamic memory. Consider the following program

```c
p = malloc(1);
q = malloc(1);
p = q;
```

We now lost access to `p`, and unable to free it. This is called a memory leak.

### Dangling Pointers

```c
p = malloc(1);
free(p);
```

At this point, `p` points to a memory location it does not own, it is dangerous to use it.

### sizeof

To allocate space for other datatypes, we take advantage of a function called `sizeof`, which will return the bytes that a data structure will need.

```c
int *a = malloc(4 * sizeof(int)); // This will allocate space for 4 integers
```

### calloc

```c
void *calloc(size_t nmemb, size_t size); // First argument is how many elements, second is size of element
```

Similar to malloc, but zeros all memory.

### realloc

```c
void *realloc(void *ptr, size_t size);
```

Change size of memory block pointed by `ptr` to `size`.

## Structs

Struct is a collection of related data items.

For example, you might have a struct called student

```c
struct student {
    char firstName[20];
    char lastName[20];
    int year;
}
```

Once we declared a struct, we can use it just like any other datatype.

```c
struct student my_student;
my_student.year = 4;
// etc...
```

### Pointer to Structs

Let's say instead of struct, we have a pointer to struct.

```c 
struct student my_student;
struct student *p = &my_student;
```

To access using `p`, you can do one of the following:

```c
(*p).year; // Dereferencing then access struct
p->year; // Shorthand
```

You can use `malloc` with structs just like any other type.

Functions can take structs as parameters.

## Linked List

Linked list in C is very easy to implement using struct

```c
struct node {
    int data;
    struct node *next;
}

// Initialize the list
struct node first;
first.data = 1;
struct node second;
second.data = 2;
first.next = &second;

// Loop though list
struct node *head = &first;
while (head->next != NULL) {
    printf("%d\n", head->data);
    head = head->next;
}
```