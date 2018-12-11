---
layout: post
title: CSCB07 Software Design - Intro to Java
date: 2018-12-11 13:36:00 -0400
tags: cscb07 course-notes
category: cscb07
---

Course notes taken for CSCB07/CSC207 at UofT (Software Design).

Introduction to Java programming. This note assumes you are somewhat knows how to program, many obvious details are ignored.

<!--more-->

## Primitive Types

Java has 8 primitive types.

* `int` - 32 bit signed integer.
* `byte` - 8 bit signed integer.
* `short` - 16 bit signed integer.
* `long` - 64 bit signed integer.
* `float` - Single precision 32 bit floating point.
* `double` - Double precision 64 bit floating point.
* `boolean` - 1 bit value.
* `char` - 16 bit unsigned integer.

### Strings

`String` is a class in Java, and it is immutable.

```java
String s = "hello";
// or
String s = new String("hello"); // This is less efficient
```

## Classes and Objects

Classes are like our own custom data types, they are blueprints from which objects are created. It models the state and behaviour of a real world object.

Objects are created out of classes. It is a software bundle of related state and behaviour.

### `Student` Example

```java
class Student {
    /**
     * private, protected, public are access modifiers.
     */
    private String firstName;
    private String lastName;
    private int mathMark;
    private int physicsMark;
    private int chemistryMark;
    private int studentNumber;
    private static int numberOfStudents = 0;
}
```

### Constructor

Constructors are used to create objects.

They have a few interesting properties:

* They use the same name as the class, and have no return type.
* If you don't code any constructors, the default one will be created for you.
* If you do provide any constructors, the default one will not be created for you. (but you can manually create a default constructor).

In our `Student` class, constructors might look like the following:

```java
class Student {
    // ... properties

    // Default constructor
    Student() {
        
    }

    // Constructor to set names
    Student(String firstName, String lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
    }

    // Constructor to set names and marks
    Student(String firstName, String lastName, int mathMark, int physicsMark, int chemistryMark) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.mathMark = mathMark;
        this.physicsMark = physicsMark;
        this.chemistryMark = chemistryMark;
    }
}
```

### Create Objects

Now we have the `Student` class, we can create 3 students by running the following code:

```java
Student a = new Student("Jack", "Wilson");
Student b = new Student("Matt", "Milley");
Student c = new Student("Pill", "Zack");
```

`a,b,c` are references with type of `Student`.

We now encounter a problem, we can't set the marks! Since constructors can't be invoked more than once.

## Setters and Getters

Setters also called mutator methods are used to control changes to an instance variable.

Getters also called accessor methods, they return the value of the instance variable.

For our student class, we can add the following getters and setters:

```java
class Student {
    // ... properties
    // ... constructors

    public int getMathMark() {
        return this.mathMark;
    }

    public void setMathMark(int mathMark) {
        this.mathMark = mathMark;
    }
    
    // physics, chemistry ignored
}
```


### Instance Methods

> Getters and setters are instance methods that depends on an instance of a class. You can create other instance methods if you wish.

```java
class Student {
    // ... properties
    // ... constructors
    // ... getters/setters

    // An instance method
    public float calculateAverage() {
        return (this.mathMark + this.physicsMark + this.chemistryMark) / 3.0f;
    }
}
```

## Public and Private

`public` and `private` are called access modifiers, there is another one called `protected`.

All `private` properties and methods are not accessable outside of the class, and it is meant to be used to hide implementation details.

`public` properties and methods are accessable outside of the class, they are used to describe behaviours.

```java
// Student.java
class Student {
    private void someMethod() {}
}

// Main.java
class Main {
    public void main(String[] args) {
        Student a = new Student();
        student.someMethod(); // Error
    }
}
```

## Static Fields and Methods

Static fields and methods do not depend on an instance.

In our student class, we have `numberOfStudents` as a static field.

```java
class Student {
    private static int numberOfStudents = 0;

    public static int getNumberOfStudents() {
        return Student.numberOfStudents;
    }
}
```

## Factory Methods

Consider the following class:

```java
class SmartPhone {
    // Construct with name
    public SmartPhone(String n) {}
    // Construct with serial number
    public SmartPhone(int n){}
}
```

When I use the class, it gets confusing, what is `String n` and what is `int n`? Since constructors have the same name, I can't really tell.

Factory methods provides abstraction on top of constructors, and they can have names.

We can refactor our code to the following:

```java
class SmartPhone {
    // Construct with name
    private SmartPhone(String n) {}
    // Construct with serial number
    private SmartPhone(int n){}

    // Factory methods
    public static SmartPhone createWithName(String n) {
        return new SmartPhone(n);
    }

    public static SmartPhone createWithSerialNumber(int n) {
        return new SmartPhone(n);
    }
}
```

> Note we changed both constructors to `private`.

We can now use the class like the following:

```java
class Main {
    public static void main(String[] args) {
        SmartPhone lgg7 = SmartPhone.createWithName("LG G7 ThinQ");
        SmartPhone generic = SmartPhone.createWithSerialNumber(123);
    }
}
```