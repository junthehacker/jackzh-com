---
layout: post
title:  "MATA22 Linear Algebra - Diagonalization"
date:   2018-08-12 10:46:00 -0400
tags: mata22 course-notes
category: mata22
---

This article is mainly notes I have taken from reading Linear Algebra (Addison-Wesley, 1995) section 5.2. For course MATA22 at UTSC.

<!--more-->

A square matrix is called diagonal if all entries not on the main diagonal are zero.

We will show that if \\(A\\) has \\(n\\) distinct eigenvalues, then the computation of \\(A^k\\) can be replaced by \\(D^k\\), where \\(D\\) is a diagonal matrix with the eigenvalues of \\(A\\) as entries.

### Matrix Summary of Eigenvalues of \\(A\\)

Let \\(A\\) be an \\(n \\times n\\) matrix and let \\(\\lambda_1, \\lambda_2, ...., \\lambda_n\\) be scalars and \\(\\vec v_1, \\vec v_2, ... , \\vec v_n \\) be nonzero vectors in n-space. Let \\(C\\) be the \\(n \\times n\\) matrix having \\(\\vec v_j\\) as \\(j\\)th column vector, and let \\(D\\) be the diagonal matrix with entries of all lambda scalars.

Then \\(AC = CD\\) if and only if all \\(\\lambda\\) are eigenvalues of \\(A\\) and \\(\\vec v_j\\) is an eigenvector of \\(A\\) corresponding to \\(\\lambda_j\\)

\\(C\\) is invertible if and only if \\(rank(C) = n\\). That case, we can write the equation as \\(D = C^{-1}AC\\).

### Diagonalizable Matrix

An \\(n \\times n\\) matrix \\(A\\) is diagonalizable if there exists an invertible matrix \\(C\\) such that \\(C^{-1}AC = D\\), a diagonal matrix.

