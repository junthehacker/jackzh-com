---
layout: post
title:  "MATA22 Linear Algebra - Eigenvalues and Eigenvectors"
date:   2018-08-03 10:46:00 -0400
tags: mata22 course-notes
category: mata22
---

This article is mainly notes I have taken from reading Linear Algebra (Addison-Wesley, 1995) section 5.1. For course MATA22 at UTSC.

<!--more-->

## Fibonacci's Rabbits

We introduce the idea of eigenvalues and eigenvectors by exploring Fibonacci's rabbits.

Suppose that newly born rabbits produce no offsprings during the first month of their lives, but each pair will produce another pair each subsequent month. Starting with \\(F_1 = 1\\) newly born pair in the first month, find the number \\(F_k\\) of pairs in the kth month. Suppose no rabbit dies.

So in the kth month, the total rabbits will be the number of rabbits from proceeding month, and the newly born rabbits in kth month.

Since our rabbits do not produce offspring during the first month of their lives, number of newly born pairs would simply be \\(F_{k-2}\\). Therefore, we have

\\[
    F_k = F_{k-1} + F_{k-2}
\\]

We set \\(F_0\\) to be 0, it is just easier to compute.

The sequence will be

\\[
    0, 1, 1, 2, 3, 5, 8, 13, 21, 34, ....
\\]

Our relation can be written in matrix form, which is

\\[
\left[\begin{matrix}
  F_k \cr
  F_{k-1}
\end{matrix}\right]
=
\left[\begin{matrix}
  1 & 1 \cr
  1 & 0
\end{matrix}\right]
\left[\begin{matrix}
  F_{k-1} \cr
  F_{k-2}
\end{matrix}\right]
=
\left[\begin{matrix}
  F_{k-1} + F_{k-2} \cr
  F_{k-1}
\end{matrix}\right]
\\]

Therefore, if we set

\\[
x_k = 
\left[\begin{matrix}
  F_k \cr
  F_{k-1}
\end{matrix}\right]
\\text{and} \\space
A = 
\left[\begin{matrix}
  1 & 1 \cr
  1 & 0
\end{matrix}\right]
\\]

We can obtain that

\\[ x_k = Ax_{k-1}\\]

If we apply this equation repeatly, we can see

\\[ x_2 = Ax_1\\]
\\[ x_3 = Ax_2 = A^2x_1\\]
\\[ x_4 = Ax_3 = A^3x_1\\]

So the relation can also be rewritten as

\\[ x_k = A^{k-1}x_1\\]

Use following code in MATLAB to compute fib rabbits

```matlab
function y = fib_rabbit(k)
    A = [1 1; 1 0];
    xk = A^(k-1)*[1;0];
    y = xk(1,1);
end
```

## Eigenvalues and Eigenvectors

### Definition

Let \\(A\\) be an \\(n \\times n\\) matrix. A scalar \\(\\lambda\\) is an eigenvalue of \\(A\\) if there is a nonzero column vector \\(\\vec v\\) in \\(R^n\\) such that \\(A\\vec v = \\lambda \\vec v\\). The vector \\(\\vec v\\) is then an eigenvector of \\(A\\) corresponding to \\(\\lambda\\).

### Compute \\(A^k\\vec x\\)

For many matrices \\(A\\), the computation of \\(A^k \\vec x\\) for a general vector \\(\\vec x\\) can be greatly simplified by first finding all eigenvalues and eigenvectors.

Suppose we found a basis \\(\\{\\vec b_1,\\vec  b_2, ... ,\\vec b_n\\}\\) for \\(R^n\\) consisting of eigenvectors of \\(A\\), then we have.

\\[
  A \\vec b_i = \\lambda_i \\vec b_i
\\]

To compute \\(A^k \\vec x\\), we first exporess \\(\\vec x\\) as a linear combination of the basis.

\\[
  \\vec x = d_1\\vec b_1 + d_2\\vec b_2 + ... + d_n \\vec b_n
\\]

Since we know \\(A^k\\vec b_i = {\\lambda_i}^k \\vec b_i\\)

\\[
  A^k\\vec x = {\\lambda_1}^kd_1\\vec b_1 + {\\lambda_2}^kd_2\\vec b_2 + ... + {\\lambda_n}^kd_n\\vec b_n
\\]

### Stable / Unstable Transformation

The above equation gives us important information on the effect of repeatedly transforming \\(R^n\\) using \\(A\\).

If at least one of the \\(\\lambda\\) is greater than 1, then we can obtain arbitrarily large magnitude vectors. In another word

\\[
  \\exists \\lambda_i > 1 \\to \\lim_{k\\to \\infty} |A^k\\vec x| = \\infty, i \\in \\{1,2,3,..., n\\}
\\]

This is called an unstable transformation of \\(R^n\\).

However, if all \\(\\lambda\\) are less than 1, we will eventually get a vector that is close to 0.

\\[
  \\forall \\lambda_i < 1 \\to \\lim_{k\\to \\infty} |A^k\\vec x| = 0, i \\in \\{1,2,3,..., n\\}
\\]

This is called a stable transformation.

If the maximum of \\(\|\\lambda_i\|\\) is 1, then the transformation is neutrally stable.

### Dominant Terms

Let's suppose that one of the \\(\\lambda\\) has a greater magnitude of all other \\(\\lambda\\)s. Then that \\(\\lambda\\) dominats the other terms. Therefore, for large values of \\(k\\), the resulting vector is almost parallel to the eigenvector that \\(\\lambda\\) corresponds to.

##### MATLAB Stuff

```matlab
% To compute eigenvalues
function y = eigenvalues(A)
    y = eig(A);
end
```

```matlab
% To compute eigenvectors, this will give you a matrix with columns representing eigenvectors
function y = eigenvectors(A)
    [V, ~] = eig(A);
    y = V;
end
```

### Computing Eigenvalues

We will use determinant to find eigenvalues of an \\(n \\times n\\) matrix. This is only practical only for relatively small matrices.

Since we said \\(A\\vec v = \\lambda \\vec v\\), we can also say \\(A\\vec v - \\lambda\\vec v = 0\\), or \\(A\\vec v - \\lambda I\\vec v = 0\\). Therefore \\(\\vec v\\) must be a solution to the system

\\[(A - \\lambda I)\\vec x = 0\\]

Eigenvalue is when the system has a nontrivial solution \\(\\vec 0\\). It has a nontrivial solution when the determinant is zero.

\\[det(A - \\lambda I) = 0\\]

If we expand the determinant, we will get a polynomial, this is called the characteristic polynomial of matrix \\(A\\). And the eigenvalues are the solutions to \\(p(\\lambda) = 0\\).

### Computing Eigenvectors

To find the eigenvectors for corresponding eigenvalues, you simply substitute the \\(I\\) with \\(\\lambda I\\), and solve for the argumented matrix \\([A - \\lambda I \| 0 ]\\)

If we found a unknown value, we usually try to factor it out and just drop it.

### Properties of Eigenvalues and Eigenvectors

Let \\(A\\) be an \\(n \\times n\\) matrix.

If \\(\\lambda\\) is an eigenvalue of \\(A\\) with \\(\\vec v\\) as a corresponding eigenvector, then \\(\\lambda^k\\) is an eigenvalue of \\(A^k\\), again with \\(\\vec v\\) as a corresponding eigenvector, for any positive integer \\(k\\).

If \\(\\lambda\\) is an eigenvalue of an invertible matrix \\(A\\) with \\(\\vec v\\) as a corresponding eigenvector, then \\(\\lambda\\) not equal to \\(0\\), and \\(1/\\lambda\\) is an eigenvalue of \\(A^{-1}\\), again with \\(\\vec v\\) as a corresponding eigenvector.

If \\(\\lambda\\) is an eigenvalue of \\(A\\), then the set \\(E_\\lambda\\) consisting of the zero vector together with all eigenvectors of \\(A\\) for this eigenvalue \\(\\lambda\\) is a subspace of n-space, the eigenspace of \\(\\lambda\\).

### Definition for Linear Transformations

This is a stupid ass definition, because \\(T\\) can be expressed as \\(A\\).

Let \\(T\\) be a linear transformation of a vector space \\(V\\) into itself. A scalar \\(\\lambda\\) is an eigenvalue of \\(T\\) if there is a nonzero vector \\(\\vec v\\) in \\(V\\) such that \\(T(\\vec v) = \\lambda \\vec v\\). The vector \\(\\vec v\\) is then an eigenvector of \\(T\\) corresponding to \\(\\lambda\\).