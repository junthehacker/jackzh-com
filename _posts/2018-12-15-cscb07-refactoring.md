---
layout: post
title: CSCB07 Software Design - Intro to Refactoring
date: 2018-12-15 11:42:00 -0400
tags: cscb07 course-notes
category: cscb07
---


Course notes taken for CSCB07/CSC207 at UofT (Software Design).

Introduction to refactoring.

<!--more-->

## Overview

Refactoring is restructuring code in a series of small, semantics-preserving transformations in order to make the code easier to maintain and modify.

* Code must still work
* Small steps only so the semantics are preserved
* Unit tests to prove the code still works
* Code should be
    * More loosely coupled
    * More cohesive modules
    * More comprehensible

## When to Refactor

You should refactor any time you see better way to do things.

You can do it without breaking the code (unit tests).

You should not refactor if code is already stable and doesn't need to change, or if it is someone else's code.

## Refactoring Process

* Make small change
* Run all tests to make sure it still works
* If it works, go to next refactoring
* If not, fix it, or undo so you still have a working system

## Code Smells

* Duplicate code
* Long methods
* Big classes
* Big switch statements
* Long navigations `a.b().c().d()`
* Lots of checking for null
* Data clumps
* Data classes