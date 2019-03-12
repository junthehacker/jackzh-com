---
layout: post
title: CSCB63 Data Structure Design and Analysis - Fibonacci Heaps 
date: 2019-03-12 13:00:00 -0400
tags: cscb63 course-notes
category: cscb63
---

Basic introduction to fibonacci heaps and some comparson with regular heaps.

<!--more-->

## Operations Supported

* `make_heap` - Create a new heap.
* `insert(H, x)` - Insert `x` into heap `H`.
* `min(H)` - Return minimum element in `H`.
* `extract_min(H)` - Return minimum element in `H` and removes it.
* `union(H1, H2)` - Creates and returns a new heap containing all elements in `H1` and `H2`.
* `decrease_key(H, x, k)` - Assigns `x` in `H` a new key `k`. `k` must be less then the current key.
* `delete(H, x)` - Delete element `x` from heap `H`.

### Complexity Comparsions With Binary-Heaps

|                   | Binary Heap Worse-Case | Fib-Heap Amortized |
|-------------------|------------------------|--------------------|
| insert            | $\Theta(lgn)$          | $\Theta(1)$        |
| extract-min       | $\Theta(lgn)$          | $O(lgn)$           |
| decrease-priority | $\Theta(lgn)$          | $\Theta(1)$        |
| union             | $\Theta(n)$            | $\Theta(1)$        |

## Structure

A fibonnacci heap includes the following components:

* A forest of heap-ordered trees.
* Roots of these trees are stored in a circular doubly-linked list.
* Pointer to minimum root, and total number of nodes.
* Siblings in a circular doubly-linked list, parent only knows one child.
* `deg(x)` is number of children is `x`'s child list.

![](https://www.evernote.com/l/Aq1GyqY27zVE5YwiM4e_BM9NY38465L1RhEB/image.png)

For each node, it contains following fields:

* key: Priority
* left, right, parent: Pointers
* child: Pointer to one child
* degree: Num of children
* mark: Boolean, useful for `decrease-priority`

## Operations

### Insert

Insert is very simple, you simply insert into the root linked-list. This takes $O(1)$.

```
insert(H, x) {
    node = new Node(x);
    node.marked = false;
    // Insert right after H.min
    node.right = H.min.right;
    node.left = H.min;
    H.min.right = node;
    node.right.left = node;
}
```

### Union

Just merge two root lists and it is done. This also takes $O(1)$.

Of course if you want to make a copy this takes longer.

```
union(H1, H2) {
    connect H1.min and H2.min
}
```