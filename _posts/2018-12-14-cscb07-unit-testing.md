---
layout: post
title: CSCB07 Software Design - Unit Testing
date: 2018-12-14 14:01:00 -0400
tags: cscb07 course-notes
category: cscb07
---


Course notes taken for CSCB07/CSC207 at UofT (Software Design).

Introduction to JUnit.

<!--more-->

## Unit Testing Overview

Unit testing is testing bits of your code in isolation.

A unit can be viewed as the smallest testable part of an application.

### Benefits

* Allows you to make big changes quickly.
    * You know everything works now because tests pass.
    * As you refactor the code, you know what breaks since you continuously running tests.

* Helps with code design.
    * Instead of directly writing code, you first outline all the conditions your code must met.

### Test Suites

There are two main ways to test:

* Ad Hoc - Test whatever occurs to you at the moment.
* Test Suite - Write a thorough set of tests.

There is a major disadvantage of writing a test suite:
* A LOT of extra programming

## Terminologies

* Test fixture - Sets up the data that are needed to run tests.
* Unit test - Test of a single class.
* Test case - Test the response of a single method to a set of inputs.
* Test suite - Collection of test cases.
* Test runner - Software to run all tests.
* Integration test - Test how well classes work together.

## `assertEquals`

Nice function to use, but just a warning, if inputs are primitives, it will use `==`, however if are objects, it will use the `.equals` method.

## Sample Unit Test

```java
package test;

import static org.junit.Assert.assertEquals;

import matrix.comparator.ComparisonType;
import org.junit.Test;

public class ComparisonTypeTest {

  @Test
  public void testShouldHaveMAX() {
    assertEquals(ComparisonType.MAX, ComparisonType.MAX);
  }

  @Test
  public void testShouldHaveMIN() {
    assertEquals(ComparisonType.MIN, ComparisonType.MIN);
  }

}

```