---
layout: post
title: CSCB07 Software Design - More Java Memory Model
date: 2018-12-14 13:45:00 -0400
tags: cscb07 course-notes
category: cscb07
---


Course notes taken for CSCB07/CSC207 at UofT (Software Design).

More topics on Java memory model.

<!--more-->

## Stack

* Values exist only within the function scope.
    * Once returns, values are freed automatically.
* Only primitives.
    * Helps stack to be small, and individual stack frames small. (so we can do recursive calls :)).
* For objects, only references (which are primitives) are passed around on stack.
* Can't be shared between threads.

> Java does not specify how references are implemented, but in C, they are integers.

* Each function have their own **stack frame**.
    * Stack frames are destroyed once method returns.


## Heap

* Objects are on the heap, they are created using `new` keyword.
* Only destroyed if garbage collector collects it.
* Object with all its instance members (variables/methods) are put on the heap.
* Can be shared by multiple threads.

## Static Variables

* The heap is divided into two parts:
    * `Object Heap Space` where all instances live.
    * `Static Heap Space` where all static members live.

![](https://www.evernote.com/l/Aq0hoi4ftghMtowCxNW0fcYUZr7Jzqy-7TwB/image.png)