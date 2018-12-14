---
layout: post
title: CSCB07 Software Design - Decorator Pattern
date: 2018-12-14 16:28:00 -0400
tags: cscb07 course-notes
category: cscb07
---

Course notes taken for CSCB07/CSC207 at UofT (Software Design).

Decorator pattern.

<!--more-->

Classes should be open for extension but closed for modification.

## Decorators

* Decorators have the same supertypes as the objects they decorate.
* Decorator add behaviour by delegating to the object it decorates and then adding its own behaviour.
* Can add at any time.

```java
public abstract class Beverage {
    String des = "unknown";

    public String getDescription() {
        return this.des;
    }

    public abstract double cost();
}

public abstract class CondimentDecorator extends Beverage {
    public abstract String getDescription();
    public abstract double cost();
}

public class Espresso extends Beverage {
    public Espresso() {
        description = "Espresso";
    }

    public double cost() {
        return 1.99;
    }
}

public class Mocha extends CondimentDecorator {
    Beverage bev;

    public Mocha(Beverage bev) {
        this.bev = bev;
    }

    public String getDescription() {
        return bev.getDescription() + ", Mocha";
    }

    public double cost() {
        return .20 + bev.cost();
    }
}

// Now you can do
Beverage bev = new Mocha(new Espresso());
// You now have mocha! with price of 2.19

```

## Decorator Design Principle

* Classes should be open for extension but closed for modification
* Systems can be extended without changing existing code.

### Tradeoffs

* Time and effort
* Introduces new abstraction can make code hard to understand

Therefore don't use decotrators everywhere.

### Advantages

* Provides a flexible alternative to using inheritance to extend functionality.
* Objects can be decorated dynamically at runtime.