---
layout: post
title: CSCB63 Data Structure Design and Analysis - Complexity
date: 2019-01-14 10:13:00 -0400
tags: cscb63 course-notes
category: cscb63
---


## Useful Manipulations


$log_b(x) = log_b(a) * log_a(x)$

$lim_{n \to \infty} \frac{2^{3n}}{2^n} = lim_{n \to \infty} {2^{2n}} = \infty$

## Complexity Table

| in Big O of | $ln(n)$ | lg_2(n) | lg_2(n^2) | (lg_2(n))^2 | n | n lg_2 n | 2^n | 2^{3n} |
|-------------|-------|---------|-----------|-------------|---|----------|-----|--------|
| ln(n)       | Y     | Y       | Y         | Y           | Y | Y        | Y   | Y      |
| log(n)      | Y     | Y       | Y         | Y           | Y | Y        | Y   | Y      |
| log(n^2)    | Y     | Y       | Y         | Y           | Y | Y        | Y   | Y      |
| (lg_2(n))^2 | N     | N       | N         | Y           | Y | Y        | Y   | Y      |
| n           | N     | N       | N         | N           | Y | Y        | Y   | Y      |
| n log n     | N     | N       | N         | N           | N | Y        | Y   | Y      |
| 2^n         | N     | N       | N         | N           | N | N        | Y   | Y      |
| 2^{3n}      | N     | N       | N         | N           | N | N        | N   | Y      |

## Complexity Proofs

### Prove $n \in O(n lg n)$

$\exists n_0, \exists c, \forall n, n \geq n_0 \implies f(n) \leq c \cdot g(n)$

$n \leq 1n$

$n \leq n \cdot log(n), n \geq 2$

$n \leq c \cdot n \cdot log(n)$

Therefore we have c = 1, and n_0 = 2.

### Prove $n log(n) \notin O(n)$

Assume for a contradiction that $nlog(n) \in O(n)$, so

$\exists c, \exists n_0, \forall n, n \geq n_0 \implies nlog(n) \leq c \cdot n$.

$log(n) \leq c$
$n \leq 2^c$

Suppose $n > 2^c$, then $n \geq n_0 \implies n \leq 2^c$. Which is a contradiction.

### Prove $6n^5 + n^2 - n^3 \in \Theta(n^5)$

First prove $6n^5 + n^2 - n^3 \in O(n^5)$

$\exists n_0, \exists c, \forall n, n \geq n_0 \implies f(n) \leq c \cdot g(n)$

$6n^5 + n^2 - n^3 \leq 6n^5 + n^2 \leq 6n^5 + n^5 \leq 7n^5$

Let c = 7, and n = 1.

Then prove $6n^5 + n^2 - n^3 \in \Omega(n^5)$

$\exists n_0, \exists c, \forall n, n \geq n_0 \implies f(n) \geq c \cdot g(n)$

$6n^5 + n^2 - n^3 \geq 6n^5 - n^3 \geq 5n^5$

Let c = 5, and n != 1.

### Prove $3n^2 - 4n \in \Omega(n^2)$

$3n^2 - 4n \geq bn^2$

$3n - 4 \geq bn$

$3n - bn \geq 4$

$n(3-b) \geq 4$

$n \geq \frac{4}{3-b}$