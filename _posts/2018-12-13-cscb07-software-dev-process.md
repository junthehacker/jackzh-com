---
layout: post
title: CSCB07 Software Design - Software Development Process
date: 2018-12-13 21:32:00 -0400
tags: cscb07 course-notes
category: cscb07
---

Course notes taken for CSCB07/CSC207 at UofT (Software Design).

CRC cards and how to properly develop software with a team.

<!--more-->

In previous note, we discussed CRC cards, they look like this:

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

Now let's convert it to an actual class!

An `InputAudioDevice` might look like the following:

```java
class InputAudioDevice extends AudioDevice {

    private StreamWriter writer;

    void writeAudioStream(byte b) {}

}
```

## `Object` Class

All classes within Java extends from `Object`, and you should always consider override some of the methods:

* `#clone() -> Object` Creates and returns a copy of this object.
* `equals(Object obj) -> boolean` Check if `obj` is equal to this one.
* `hashCode() -> int` Returns a hash value.
* `toString() -> String` Returns string representation.

## Always Check Parameters

You should always check parameter validity, and indicate in JavaDoc what exception might be thrown within this method.

Not really necessary within private methods, since you have full control over them.

## Software Development Process

### Introduction

In many courses, programs are coded once and thrown away. However, in real life, that is not the case, and development is an agile process.

### Common Elements Within Software Development

* Requirements
    * What do we need to build?
* Design
    * How can we build the thing so it meets the requirement?
* Implementation
    * Build it!
* Verification
    * Does it work?
* Maintenance
    * Fixing/adding/changing features.

### Validation and Verification

* Validation
    * Test the specification, not the software.
    * Are we building the right thing?
* Verification
    * Testing the software we built.
    * Does it follow our specification?

![](https://www.evernote.com/l/Aq0E9ia59mlBq4EVzVBI7kKCGfpkftxDDw8B/image.png)

### Waterfall Model

![](https://www.evernote.com/l/Aq2LDGa-GXJOZ4Y5IanWdB88NtoGkcRHgmsB/image.png)

* Advantages
    * Easy to use
    * Works well for small projects
    * Cost effective
* Disadvantages
    * Only test one time after everything has been built
    * High risk
    * Not flexible
    * Bad for complex projects

It does not work well when
* Requirement changes
* You are not 100% sure about the requirements
* New ideas come up

### Iterative Development

Don't finish all features in one go, you code, get feedback, then code again...

### Incremental Development

Code only what you need now, code the rest piece by piece.

### Agile Methods

Agility is the ability to both create and respond to change in order to profit in a turbulent business environment.

Agile is
* People oriented
* Easily responds to changes
* Results in the creation of working systems that meets the needs of its stakeholders

Traditional software development timeline:

```
Requirements -> Build -> Test -> Release
```

You can only use the software at the end, and bugs are found late.

Agile timeline:

```
Build/Release -> Build/Release -> Build/Relase -> ....
```

Good visibility of progress, find bugs early, easy to respond to changes, use the software early.

## User Stories

Users usually do not use the same terms as software developers.

User stories help to cleaify requirements and can be used for clarification when communicating with the client.

Can also used to identify different types of users.

Examples:

```
As a store associate, I can search for a book by its ISBN, so that I can determine the book's in-stock quantity for the store.
```

```
As a bookstore customer, I can search for books by the Author's name, so that I can easily find all book by that author.
```

## Agile Tools

There are a few important tools we use in agile development process:

* User stories to drive design
* Continuous unit testing
* Pair programming
* Lightweight design as code is written and features are added
* Continuous refactoring

## Scrum Agile Development Process

It is iterative and incremental, and there are a few roles:

* Product Owner
    * The customer
    * Who is paying for this
* Team
    * The Team is responsible for managing itself and has the full authority to do anything to meet the Sprint goal within the guidelines, standards, and conventions of the organization and of Scrum.
* Scrum Master
    * Maintains the process, enforces the rules
    * Remove development obstacles
    * Facilitates communications
    * The Scrum Master is responsible for the success of the project, and he or she helps increase the probability of success by helping the Product Owner select the most valuable product backlog and by helping the Team turn that backlog into functionality.

### Scrum Method

* Product Backlog - Features of the product
    * Master list of all functionalities in the product
    * Does not have to be complete

* Sprint Backlog - Subset of features to work on for the sprint
    * List of tasks that the team is committing they will do
    * Must be drawn from product backlog, and broken down to smaller items
    * Chosen based on the priority

* Code Sprint - Can take weeks to complete

* Daily Scrum - Daily meetings
    * What did you work on?
    * What will you work on?
    * Is there any issue that you are currently blocked on?
    * Usually short, like 15 mins.

Final Product - The software

![](https://www.evernote.com/l/Aq3AC7U482hJLbArItqeZ5BfrI-fPs-j-gIB/image.png)