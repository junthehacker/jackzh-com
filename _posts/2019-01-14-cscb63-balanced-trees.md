---
layout: post
title: CSCB63 Data Structure Design and Analysis - Balanced Trees
date: 2019-01-14 13:13:00 -0400
tags: cscb63 course-notes
category: cscb63
---

## Why balanced trees?

Binary tree: $O(n)$ for `insert`, `delete` and `search`.

<!--more-->

Some better trees:
* AVL Trees
* B-trees
* Splay trees
* Weight ...

## AVL Trees

Similar to binary search tree. But also different in a few ways:

* The height of an AVL tree is $O(log n)$.
* Each internal node has a balance property equal to -1, 0, 1.
* Balance value = height of the left subtree - height of the right sub tree.

### Balance Property

Have to store the height of sub-trees.

-1 - Right heavy, +1 - Left heavy, 0 - Balanced.

### Searching

* Same as BST

### Insertion

After insert, if a node's balance factor is not -1, 0 or +1, we have to do one single rotation to fix it.

If there is a "bent", then we have to do double rotation

```
for (X = parent(Z); X != null; X = parent(Z)) { // Loop (possibly up to the root)
    // BalanceFactor(X) has to be updated:
    if (Z == right_child(X)) { // The right subtree increases
        if (BalanceFactor(X) > 0) { // X is right-heavy
            // ===> the temporary BalanceFactor(X) == +2
            // ===> rebalancing is required.
            G = parent(X); // Save parent of X around rotations
            if (BalanceFactor(Z) < 0)      // Right Left Case     (see figure 5)
                N = rotate_RightLeft(X, Z); // Double rotation: Right(Z) then Left(X)
            else                           // Right Right Case    (see figure 4)
                N = rotate_Left(X, Z);     // Single rotation Left(X)
            // After rotation adapt parent link
        } else {
            if (BalanceFactor(X) < 0) {
                BalanceFactor(X) = 0; // Z’s height increase is absorbed at X.
                break; // Leave the loop
            }
            BalanceFactor(X) = +1;
            Z = X; // Height(Z) increases by 1
            continue;
        }
    } else { // Z == left_child(X): the left subtree increases
        if (BalanceFactor(X) < 0) { // X is left-heavy
            // ===> the temporary BalanceFactor(X) == –2
            // ===> rebalancing is required.
            G = parent(X); // Save parent of X around rotations
            if (BalanceFactor(Z) > 0)      // Left Right Case
                N = rotate_LeftRight(X, Z); // Double rotation: Left(Z) then Right(X)
            else                           // Left Left Case
                N = rotate_Right(X, Z);    // Single rotation Right(X)
            // After rotation adapt parent link
        } else {
            if (BalanceFactor(X) > 0) {
                BalanceFactor(X) = 0; // Z’s height increase is absorbed at X.
                break; // Leave the loop
            }
            BalanceFactor(X) = –1;
            Z = X; // Height(Z) increases by 1
            continue;
        }
    }
    // After a rotation adapt parent link:
    // N is the new root of the rotated subtree
    // Height does not change: Height(N) == old Height(X)
    parent(N) = G;
    if (G != null) {
        if (X == left_child(G))
            left_child(G) = N;
        else
            right_child(G) = N;
        break;
    } else {
        tree->root = N; // N is the new root of the total tree
        break;
    }
    // There is no fall thru, only break; or continue;
}
// Unless loop is left via break, the height of the total tree increases by 1.
```

### Deletion

* If the key is a leaf, delete and rebalance.

### Tree Height

Maximum possible height is $log(n)$, if we have $n$ nodes.

If the height is $h$, let `minsize(h)` be the minimum number of nodes for an AVL tree of height $h$.

Then

```
minsize(0) = 0,
minsize(1) = 1,
minsize(h + 2) = 1 + minsize(h + 1) + minsize(h)
```

minsize(h) = fib(h+2) - 1 (why?)

