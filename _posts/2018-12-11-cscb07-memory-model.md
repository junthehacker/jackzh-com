---
layout: post
title: CSCB07 Software Design - Java Memory Model & CRC
date: 2018-12-11 14:50:00 -0400
tags: cscb07 course-notes
category: cscb07
---

Course notes taken for CSCB07/CSC207 at UofT (Software Design).

Java memory model and some CRC.

<!--more-->

I have already covered memory model in more depth here: [CSCB09 - Intro to C]({% post_url 2018-08-08-cscb09-intro-to-c %}#memory-model), therefore this note won't cover too much detail.


## Stack and Heap

Stack:

* Local variables are stored within the stack, and will be freed if the variable goes out of scope.
* Faster than heap.
* Stores local data, return addresses, used for function parameter passing.
* Can have overflow if too much stack is used.

Heap:

* In Java, objects are allocated on the heap using `new`.
* Slower than stack.
* Variables must be destroyed manually, in Java, there is a "garbage collector" to do this.
* Responsible for memory leaks.

Informally, following code in memory would look like:

```java
public static void main(String[] args) {
    Student a = new Student();
    Student b = new Student();
    Student c = new Student();
}
```

![](https://www.evernote.com/l/Aq2lf1PZXYVJepxAH6KDXMs_sZJ0H3SrPRsB/image.png)

> All primitive types are stored within stack.

## Inheritance

You can create a general class and let other sub-classes extend it.

Class that is inherited is called super class, class that is inheriting is called sub class.

> Class DO NOT inherit static fields / methods. No do it inherit private and no modifier (package protected) fields / methods.

Sub classes can call `super()` to access super class' constructor, and this should be the first thing you call in sub-class constructor.

### Why Encapsulation?

It seperates implementation details from behaviour.

Steve McConnell in his book, ‘Code Complete’ uses the analogy of an ice berg.

Only a small portion of iceberg is visible on the surface, most of it is hidden underwater. 

Similarly, in our software design the visible parts of our modules/classes constitute their public interface and this is exposed to the outside world. The rest of it should be hidden to the naked eye.

### Overriding

When methods have the same name and signature, the method is overridden.

```java
class Super() {
    int myMethod(int a) {
        return a;
    }
}
```

```java
class Sub extends Super {
    // Overrides Super.myMethod
    int myMethod(int b) {
        return 2;
    }
}
```

### Overloading

When methods have the same name, but different signature (input types, not including return types), the method is overloaded.

```java
class Super() {
    int myMethod(int a) {
        return a;
    }
}
```

```java
class Sub extends Super {
    // Overloads Super.myMethod
    int myMethod(float b) {
        return 2;
    }
}
```

> In Java, everything inherits from Object class.

### IS-A Relationship

```java
class Car {}
class Sportscar extends Car {}
```

Then we call Sportscar is a Car, which is an Object.

### HAS-A Relationship

Also called composition or aggregation.


```java
class Engine {}
class Car {
    private Engine e;
}
```

Then we call Car has an Engine. We can also say Car is collaborating with Engine.

## Single Responsibility Principle

In OOP, SRP states that:

* Every class should have a single responsibility.
* the responsibility should be entirely encapsulated by the class.

[https://blog.cleancoder.com/uncle-bob/2014/05/08/SingleReponsibilityPrinciple.html](https://blog.cleancoder.com/uncle-bob/2014/05/08/SingleReponsibilityPrinciple.html)

> A class should have one and only one reason to change.

## CRC Cards

A CRC card looks like the following:

```
------------------------------------------------
| Class: InputAudioDevice                      |
| Super-classes: AudioDevice                   |
| Sub-classes: Microphone                      |
| Responsibility:                              |
|     - Passes audio signal to computer.       |
| Collaborators:                               |
|     - StreamWriter                           |
------------------------------------------------
```

Personally I think CRC cards are stupid and hard to read for large scale projects. As it is impossible to comprehend if you have say 200 cards (where is the entry point?), how do I cross reference?