---
layout: post
title: CSCB07 Software Design - Polymorphism, Abstract Classes, Interfaces, Liskov, Singleton
date: 2018-12-14 14:01:00 -0400
tags: cscb07 course-notes
category: cscb07
---


Course notes taken for CSCB07/CSC207 at UofT (Software Design).

Polymorphism, Abstract Classes, Interfaces, Liskov, Singleton.

<!--more-->

## Polymorphism

* Poly = many
* Morph = change of form

The concept is basically that you should have a general super class, and sub classes takes different shapes and forms of the super class.

A basic example would be:

```java
class Cat extends Animal {
    public void talk() {
        System.out.println("meow");
    }
}

class Snake extends Animal {
    public void talk() {
        System.out.println("szzzz");
    }
}

class Animal {
    public void talk() {
        System.out.println("...");
    }
}
```

### Advantages

* Enables you to program in the general rather then specific.
* Enables you to write programs that processes objects that share the same super class.
* Easily extensible.

### Recap

* In polymorphism you have a base class reference pointing to an object of subclasses.
* Super class ref can only be used to invoke methods declared within the super class. Otherwise it will cause compilation errors.
* If you want to perform specific tasks, you can downcast it.

### Downcasting

```java
Animal a = new Cat();
Cat c = (Cat)a;
```

## Function Binding

Function binding maps a function call to function implementation. It decides when I do `a.talk()`, which function should be invoked.


### Static Binding

This binds call during compile time.

### Dynamic Binding

Runtime binding. This is used in polymorphism, and this is why it works.

```java
Animal a = new Cat();
a.talk(); // This is binded to Cat.talk not Animal.talk during runtime.
```

Dynamic binding are used for all methods except:

* Private instance methods
* Overloaded instance methods
* Instance methods that are final.

## `final` Keyword

If a method is `final`, it
* Cannot be overridden in subclass.
* `private` and `static` are implicitly `final`.

If a class is `final`, it
* Can't be extended
* All methods in a `final` class are implicitly `final`.

## Interfaces

A class can implement multiple interfaces but can only extend one class.

CLasses from different inheritance tree can implement the same interface.

Interfaces are used when different classes have their own "characteristics", for example:

```java
class ComputerScienceStudent extends Student implements AntiSocial, LovesPizza {

    public void beAwkward() {

    }

    public void eatPizza() {

    }

}
```

You can't create a new interface instance, since nothing is implemented.

## Abstract Classes

Abstract class is like the middleground of classes and interfaces, it can contain abstract methods that must be implemented.

```java
public abstract class Student {
    public String getName() {
        return "haha";
    }

    abstract public void study();
}
```

You can't create instance of abstract classes.

## Singleton Pattern

Singleton is used when multiple other instances must share a single instance. For example, file system.

```java
public class FS {
    public static FS ref = null;
    private FS(){}
    public static FS createInstance() {
        if(ref == null) ref = new FS();
        return ref;
    }
}
```

## Liskov Substitution Principle

"If it looks like a duck, quacks like a duck, but needs batteries, you probably have the wrong abstraction".

For any important properties of a `type`:
* Should also hold for its subtypes.
* And method written for `type` should work equally well on its `subtypes`.