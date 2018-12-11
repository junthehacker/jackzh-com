---
layout: post
title:  "MATA22 Linear Algebra - Determinants"
date:   2018-07-22 23:17:00 -0400
tags: mata22 course-notes
category: mata22
---

This article is mainly notes I have taken from reading Linear Algebra (Addison-Wesley, 1995) section 4.1. For course MATA22 at UTSC.

<!--more-->

## The Area of a Parallelogram

Area of the parallelogram determined by two nonzero and nonparallel vectors \\(a = [a_1, a_2]\\) and \\(b = [b_1, b_2]\\) is:

\\[\\text{Area} = \\left\\|{a}\\right\\| h = \\left\\|{a}\\right\\| \\left\\|{b}\\right\\|(sin\\theta)  = \\left\\|{a}\\right\\| \\left\\|{b}\\right\\|\\sqrt{1-cos^2\\theta}\\]

Where \\(\\theta\\) is the angle between two vectors.

> We obtain the last equation using trig identity \\(sin^2x + cos^2x = 1\\).

Now let's square the area equation

\\[\\text{Area}^2 = \\left\\|{a}\\right\\|^2 \\left\\|{b}\\right\\|^2 (1-cos^2\\theta) \\]
\\[= \\left\\|{a}\\right\\|^2 \\left\\|{b}\\right\\|^2 - \\left\\|{a}\\right\\|^2 \\left\\|{b}\\right\\|^2 cos^2\\theta\\]
\\[=\\left\\|{a}\\right\\|^2 \\left\\|{b}\\right\\|^2 - (a \\cdot b)^2\\]
> This step is because recall \\(a \\cdot b = \\left\\|{a}\\right\\| \\left\\|{b}\\right\\|(cos\\theta)\\)

\\[=(a_1^2 + a_2^2)(b_1^2 + b_2^2) - (a_1b_1 + a_2b_2)^2\\]

> And this is in fact the same as following

\\[=(a_1b_2 - a_2b_1)^2\\]

We can now obtain the area equation for our parallelogram

\\[\\text{Area} = \|a_1b_2 - a_2b_1\|\\]

This equation with absolute value bar is also known as the **determinant** if the matrix

\\[ A =
\left[\begin{matrix}
  a_1 & a_2 \cr
  b_1 & b_2
\end{matrix}\right]
\\]

We denote it with \\(det(A)\\)

\\[ det(A) = 
\left|\begin{matrix}
  a_1 & a_2 \cr
  b_1 & b_2
\end{matrix}\right| = a_1b_2 - a_2b_1
\\]

> This is also known as second-order determinant.

## The Cross Product

Second-order determinants can also be useful when trying to find perpendicular vectors in \\(R^3\\).

Let's say we have two vectors in \\(R^3\\), \\(p\\) and \\(q\\). To find a vector \\(c\\) that is perpendicular to both, we can simply use the following equation:

\\[ c = 
\left|\begin{matrix}
  b_2 & b_3 \cr
  c_2 & c_3
\end{matrix}\right|i - 
\left|\begin{matrix}
  b_1 & b_3 \cr
  c_1 & c_3
\end{matrix}\right|j +
\left|\begin{matrix}
  b_1 & b_2 \cr
  c_1 & c_2
\end{matrix}\right|k 
\\]

> We assume \\(i,j,k\\) are unit coordinate vectors in \\(R^3\\).

The vector we obtained \\(c\\), is perpendicular to both \\(p\\) and \\(q\\). And \\(c\\) is called a cross product of \\(p\\) and \\(q\\), denoted by \\(p \\times q\\).

#### The Cross Product of 2 Vectors in \\(R^3\\) is Perpendicular to Both Vectors

**Proof:**

Let \\(p\\) and \\(q\\) be vectors in \\(R^3\\), let \\(\\vec c = \\vec p \\times \\vec q\\).

By defination of cross product, we obtain

\\[ \\vec c = 
(p_2q_3 - p_3q_2)i - 
(p_1q_3 - p_3q_1)j +
(p_1q_2 - p_2q_1)k
\\]

Which is simply the following vector

\\[ \\vec c = 
[p_2q_3 - p_3q_2, -p_1q_3 + p_3q_1, p_1q_2 - p_2q_1]
\\]

1, Verify this vector is perpendicular to \\(p\\)

\\[\\vec c \\cdot \\vec  p = (p_2q_3 - p_3q_2)p_1 + (-p_1q_3 + p_3q_1)p_2 + (p_1q_2 - p_2q_1)p_3\\]
\\[= (p_2q_3p_1 - p_3q_2p_1) + (-p_1q_3p_2 + p_3q_1p_2) + (p_1q_2p_3 - p_2q_1p_3)\\]
\\[= p_2q_3p_1 - p_3q_2p_1 -p_1q_3p_2 + p_3q_1p_2 + p_1q_2p_3 - p_2q_1p_3\\]
\\[=0\\]

Therefore \\(\\vec c\\) is perpendicular to \\(\\vec p\\).

2, Verify this vector is perpendicular to \\(\\vec q\\)

\\[\\vec c \\cdot \\vec  p = (p_2q_3 - p_3q_2)q_1 + (-p_1q_3 + p_3q_1)q_2 + (p_1q_2 - p_2q_1)q_3\\]
\\[= (p_2q_3q_1 - p_3q_2q_1) + (-p_1q_3q_2 + p_3q_1q_2) + (p_1q_2q_3 - p_2q_1q_3)\\]
\\[= p_2q_3q_1 - p_3q_2q_1 -p_1q_3q_2 + p_3q_1q_2 + p_1q_2q_3 - p_2q_1q_3\\]
\\[=0\\]

Therefore \\(\\vec c\\) is perpendicular to \\(\\vec q\\).

Since 1 and 2 both holds, \\(\\vec c\\) is perpendicular to both \\(\\vec q\\) and \\(\\vec p\\).

Q.E.D.

#### The Area of The Parallelogram Determined by \\(\\vec b\\) and \\(\\vec c\\) in \\(R^3\\) is \\(\\|\\vec b \\times \\vec{c} \\|\\)

The magnitude of this newly created perpendicular vector is in fact the area of the parallelogram determined by \\(\\vec b\\) and \\(\\vec c\\) in \\(R^3\\).

We show this by repeating the steps we have done for \\(R^2\\)

\\[
\\text{Area}^2 = \\|\\vec b\\|^2\\|\\vec c\\|^2 - (\\vec b \\cdot \\vec c)^2
\\]

\\[
= (b_1^2 + b_2^2 + b_3^2)(c_1^2 + c_2^2 + c_3^2) - (b_1c_1 + b_2c_2 + b_3c_3)^2
\\]

And this is in fact the following

\\[
\left|\begin{matrix}
  b_2 & b_3 \cr
  c_2 & c_3
\end{matrix}\right|^2 + 
\left|\begin{matrix}
  b_1 & b_3 \cr
  c_1 & c_3
\end{matrix}\right|^2 +
\left|\begin{matrix}
  b_1 & b_2 \cr
  c_1 & c_2
\end{matrix}\right|^2
\\]

> Following step is possible because
\\[
\\sqrt{\left|\begin{matrix}
  b_2 & b_3 \cr
  c_2 & c_3
\end{matrix}\right|^2 + 
\left|\begin{matrix}
  b_1 & b_3 \cr
  c_1 & c_3
\end{matrix}\right|^2 +
\left|\begin{matrix}
  b_1 & b_2 \cr
  c_1 & c_2
\end{matrix}\right|^2}
\\]
is simply the magnitude of the cross product.

By taking the square roots, we obtain \\(\\|\\vec b \\times \\vec c\\|\\) = Area.

## The Volume of a Box

![](https://www.evernote.com/l/Aq3XHGlweR1JlYzfgn8ZJIHBbdMmDvhUHjsB/image.png)
> Linear Algebra (Addison-Wesley, 1995)

The volume of a box determined by \\(a, b, c\\) in \\(R^3\\) can be found by

\\[
  h = \\|\\vec a\\| \|cos \\theta\| = \\frac{\\|\\vec b \\times \\vec c\\|\\|\\vec a\\|\|cos \\theta\|}{\\|\\vec b \\times \\vec c\\|} = \\frac{(\\vec b \\times \\vec c) \\cdot \\vec a}{\\|\\vec b \\times \\vec c\\|}
\\]

\\[
  \\text{Volume} = \\|\\vec b \\times \\vec c\\|h = \|(\\vec b \\times \\vec c) \\cdot \\vec a\|
\\]

\\[
  \\text{Volume} = \|a_1(b_2c_3 - b_3c_2) - a_2(b_1c_3 - b_3c_1) + a_3(b_1c_2 - b_2c_1)\|
\\]

We call the number within absolute value signs the third-order determinant.

Which is the determinant of the matrix

\\[ A =
\left[\begin{matrix}
  a_1 & a_2 & a_3 \cr
  b_1 & b_2 & b_3 \cr
  c_1 & c_2 & c_3
\end{matrix}\right]
\\]

We can compute it using the following formula

\\[ det(A) = 
a_1\left|\begin{matrix}
  b_2 & b_3 \cr
  c_2 & c_3
\end{matrix}\right| - 
a_2\left|\begin{matrix}
  b_1 & b_3 \cr
  c_1 & c_3
\end{matrix}\right| +
a_3\left|\begin{matrix}
  b_1 & b_2 \cr
  c_1 & c_2
\end{matrix}\right|
\\]

## Properties of the Cross Product in \\(R^3\\)

#### Anticommutativity

**Therom:** \\(\\vec b \\times \\vec c = -(\\vec c \\times \\vec b)\\)

**Proof:**

Let \\(\\vec b, \\vec c\\) be vectors within \\(R^3\\), then by defination we have

\\[\\vec b \\times \\vec c = 
\\vec i \left|\begin{matrix}
  b_2 & b_3 \cr
  c_2 & c_3
\end{matrix}\right| -
\\vec j \left|\begin{matrix}
  b_1 & b_3 \cr
  c_1 & c_3
\end{matrix}\right| +
\\vec k \left|\begin{matrix}
  b_1 & b_2 \cr
  c_1 & c_2
\end{matrix}\right|
\\]
By defination of second-order determinants, we have
\\[
  = \\vec i(b_2c_3 - b_3c_2) - \\vec j(b_1c_3 - b_3c_1) + \\vec k(b_1c_2 - b_2c_1)
\\]
\\[
  = [b_2c_3 - b_3c_2, -b_1c_3 + b_3c_1, b_1c_2 - b_2c_1]
\\]
Take out \\(-1\\) from the vector we will have
\\[
  = -[b_3c_2 - b_2c_3, b_1c_3 - b_3c_1, b_2c_1 - b_1c_2]
\\]
Do some simple reordering, we can conclude
\\[
  = -[c_2b_3 - c_3b_2, - c_1b_3 + c_3b_1 , c_1b_2 - c_2b_1]
\\]
\\[= 
-(\\vec i \left|\begin{matrix}
  c_2 & c_3 \cr
  b_2 & b_3
\end{matrix}\right| -
\\vec j \left|\begin{matrix}
  c_1 & c_3 \cr
  b_1 & b_3
\end{matrix}\right| +
\\vec k \left|\begin{matrix}
  c_1 & c_2 \cr
  b_1 & b_2
\end{matrix}\right|)
\\]

Which is by defination \\(-(\\vec c \\times \\vec b)\\).

Q.E.D.

#### Nonassociativity of \\(\\times\\)

**Therom:** \\(\\vec a \\times (\\vec b \\times \\vec c)\\) is usually not equal to \\((\\vec a \\times \\vec b) \\times \\vec c\\)

**Proof:**

Since we need to prove that they are generally different, we can simply only look at the first element of the resulting vector, if it is different, then by logic, the whole vector is different.

By defination, \\(\\vec b \\times \\vec c\\) is

\\[
  [b_2c_3 - b_3c_2, b_1c_3 - b_3c_1, b_1c_2 - b_2c_1]
\\]

By defination, the first element of \\(\\vec a \\times (\\vec b \\times \\vec c)\\) is

\\[ a_2b_1c_2 - a_2b_2c_1 - a_3b_1c_3 + a_3b_3c_1 \\]

By defination, \\(\\vec a \\times \\vec b\\) is

\\[
  [a_2b_3 - a_3b_2, a_1b_3 - a_3b_1, a_1b_2 - a_2b_1]
\\]

By defination, the first element of \\((\\vec a \\times \\vec b) \\times \\vec c\\) is

\\[
  a_1b_3c_3 - a_3b_1c_3 - a_1b_2c_2 + a_2b_1c_2
\\]

Which is clearly different, thus our therom holds.

Q.E.D.

#### Distributive Properties

**Therom 1:**
\\(\\vec a \\times (\\vec b + \\vec c) = (\\vec a \\times \\vec b) + (\\vec a \\times \\vec c)\\)

**Proof:**

By defination \\(\\vec b + \\vec c\\) is

\\[
  [b_1 + c_1, b_2 + c_2, b_3 + c_3]
\\]

By defination \\(\\vec a \\times (\\vec b + \\vec c)\\) is

\\[
\\vec i \left|\begin{matrix}
  a_2 & a_3 \cr
  b_2 + c_2 & b_3 + c_3
\end{matrix}\right| -
\\vec j \left|\begin{matrix}
  a_1 & a_3 \cr
  b_1 + c_1 & b_3 + c_3
\end{matrix}\right| +
\\vec k \left|\begin{matrix}
  a_1 & a_2 \cr
  b_1 + c_1 & b_2 + c_2
\end{matrix}\right|
\\]

Which is

\\[
  [a_2b_3 + a_2c_3 - a_3b_2 - a_3c_2, - a_1b_3 - a_1c_3 + a_3b_1 + a_3c_1, a_1b_2 + a_1c_2 - a_2b_1 - a_2c_1]
\\]

Regroup and we will get

\\[
  [(a_2b_3 - a_3b_2) + (a_2c_3 - a_3c_2), (a_1b_3 - a_3b_1) + (a_1c_3 - a_3c_1), (a_1b_2 - a_2b_1) + (a_1c_2  - a_2c_1)]
\\]

\\[
= (\\vec a \\times \\vec b) + (\\vec a \\times \\vec c)
\\]

Q.E.D.

**Therom 2:**
\\((\\vec a + \\vec b) \\times c = (\\vec a \\times \\vec c) + (\\vec b \\times \\vec c)\\)

**Proof:**

By defination \\(\\vec a + \\vec b\\) is

\\[
  [a_1 + b_1, a_2 + b_2, a_3 + b_3]
\\]

By defination \\((\\vec a + \\vec b) \\times c\\) is

\\[
\\vec i \left|\begin{matrix}
  a_2 + b2 & a_3 + b_3 \cr
  c_2 & c_3
\end{matrix}\right| -
\\vec j \left|\begin{matrix}
  a_1 + b_1 & a_3 + b_3 \cr
  c_1 & c_3
\end{matrix}\right| +
\\vec k \left|\begin{matrix}
  a_1 + b_2 & a_2 + b_2 \cr
  c_1 & c_2
\end{matrix}\right|
\\]

Which is

\\[
  [c_3a_2 + c_3b_2 - c_2a_3 - c_2b_3, - c_3a_1 - c_3b_1 + c_1a_3 + c_1b_3, c_2a_1 + c_2b_2 - c_1a_2 - c_1b_2]
\\]

Regroup and we will get

\\[
  [(c_3a_2 - c_2a_3) + (c_3b_2  - c_2b_3), (- c_3a_1 + c_1a_3) + (- c_3b_1 + c_1b_3), (c_2a_1  - c_1a_2)+ (c_2b_2 - c_1b_2)]
\\]

\\[
=(\\vec a \\times \\vec c) + (\\vec b \\times \\vec c)
\\]

Q.E.D.

#### Perpendicularity of \\(\\vec b \\times \\vec c\\) to both \\(\\vec b\\) and \\(\\vec c\\)

**Therom:** \\(\\vec b \\cdot (\\vec b \\times \\vec c) = (\\vec b \\times \\vec c) \\cdot \\vec c = 0\\)

We have already proven this.

#### Area property

**Therom:** \\(\\|\\vec b \\times \\vec c\\|\\) = Area of the parallelogram determined by \\(\\vec b\\) and \\(\\vec c\\)

We have already shown this.

#### Volume property

**Therom:** \\(\\vec a \\cdot (\\vec b \\times \\vec c) = (\\vec a \\times \\vec b) \\cdot c = \\pm \\) Volume of the box determined by \\(\\vec a, \\vec b\\) and \\(\\vec c\\).

We have already shown this.

#### Formula for calculation of \\(\\vec a \\times (\\vec b \\times \\vec c)\\)

**Therom:** \\(\\vec a \\times (\\vec b \\times \\vec c) = (\\vec a \\cdot \\vec c)\\vec b - (\\vec a \\cdot \\vec b)\\vec c\\)

**Proof:**

We first find \\(\\vec b \\times \\vec c\\), which by defination is

\\[
  [b_2c_3 - b_3c_2, -b_1c_3 + b_3c_1, b_1c_2 - b_2c_1]
\\]

Then attempt to find \\(\\vec a \\times (\\vec b \\times \\vec c)\\)

\\[
\\vec i \left|\begin{matrix}
  a_2 & a_3 \cr
  -b_1c_3 + b_3c_1 & b_1c_2 - b_2c_1
\end{matrix}\right| -
\\vec j \left|\begin{matrix}
  a_1 & a_3 \cr
  b_2c_3 - b_3c_2 & b_1c_2 - b_2c_1
\end{matrix}\right| +
\\vec k \left|\begin{matrix}
  a_1 & a_2 \cr
  b_2c_3 - b_3c_2 & -b_1c_3 + b_3c_1
\end{matrix}\right|
\\]

\\[
  [a_2b_1c_2 - a_2b_2c1 - a_3b_1c_3 + a_3b_3c_1, -a_1b_1c_2 + a_1b_2c_1 + a_3b_2c_3 - a_3b_3c_2, -a_1b_1c_3 + a_1b_3c_1 - a_2b_2c_3 + a_2b_3c_2]
\\]

Now find \\((\\vec a \\cdot \\vec c)\\vec b - (\\vec a \\cdot \\vec b)\\vec c\\), which is

\\[
  (a_1c_1 + a_2c_2 + a_3c_3) \\vec b - (a_1b_1 + a_2b_2 + a_3b_3) \\vec c
\\]

\\[
  = [a_1b_1c_1 + a_2b_1c_2 + a_3b_1c_3, a_1b_2c_1 + a_2b_2c_2 + a_3b_2c_3, a_1b_3c_1 + a_2b_3c_2 + a_3b_3c_3] -
\\]

\\[
  [a_1b_1c_1 + a_2b_2c_1 + a_3b_3c_1, a_1b_1c_2 + a_2b_2c_2 + a_3b_3c_2, a_1b_1c_3 + a_2b_2c_3 + a_3b_3c_3]
\\]

We simplify this expression and will get

\\[
  [a_2b_1c_2 + a_3b_1c_3 - a_2b_2c_1 - a_3b_3c_1, a_1b_2c_1 + a_3b_2c_3 - a_1b_1c_2 - a_3b_3c_2, a_1b_3c_1 + a_2b_3c_2 - a_1b_1c_3 - a_2b_2c_3]
\\]

Which is equvilent to \\(\\vec a \\times (\\vec b \\times \\vec c)\\).

\\(Q.E.D.\\)