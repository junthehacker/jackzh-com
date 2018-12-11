---
layout: post
title:  "MATA22 Linear Algebra - Determinants of a Square Matrix"
date:   2018-07-25 05:07:00 -0400
tags: mata22 course-notes
category: mata22
---

This article is mainly notes I have taken from reading Linear Algebra (Addison-Wesley, 1995) section 4.2. For course MATA22 at UTSC.

<!--more-->

## Minor Matrix \\(A_{ij}\\)

Let's first define what is a minor matrix.

A minor matrix \\(A_{ij}\\) is the matrix \\(A\\) with its \\(i\\)th row and \\(j\\)th coloumn crossed out.

With minor matrix notation, we can write the third-order determinant as following:

\\[ a_{11} \|A_{11}\| - a_{12}\|A_{12}\| + a_{13}\|A_{13}\| \\]

The numbers \\(a\prime_{11} = \|A_{11}\|\\), \\(a\prime_{12} = \|A_{12}\|\\), and \\(a\prime_{13} = \|A_{13}\|\\) are called the cofactors of \\(a_{11}\\), \\(a_{12}\\), \\(a_{13}\\)

We can now define the cofactor of \\(a_{ij}\\) in matrix \\(A\\) is

\\[a\prime_{ij} = (-1)^{i+j} det(A_{ij})\\]

Then the determinant is simply

\\[a_{11}a\prime{11} + a_{12}a\prime{12} + ... + a_{1n}a\prime{1n}\\]

This is called expansion by minors on the first row.

#### General Expansion by Minors

Let \\(A\\) be an \\(n \times n\\) matrix, and let \\(r\\) and \\(s\\) be any selections from the list of numbers \\(1,2,...,n\\). Then

\\[det(A) = a_{r1}a\prime_{r1} + a_{r2}a\prime_{r1} + ... + a_{rn}a\prime_{rn}\\]

also

\\[det(A) = a_{1s}a\prime_{1s} + a_{2s}a\prime_{2s} + ... + a_{ns}a\prime_{ns}\\]

## Determinant Properties

#### The Transponse Property

**Therom:** For any square matrix \\(A\\), we have \\(det(A) = det(A^T)\\)

**Proof:**

Order 1 determinants:

\\(a_{11} = a_{11}\\), ╮(╯_╰)╭

Order 2 determinants:

\\(b_1c_2 - b_2c_1 = b_1c_2 - c_1b_2\\)

Let \\(n > 2\\), assume property holds for square matrices of size smaller than \\(n \times n\\).

\\[det(A) = a_{11}\|A_{11}\| - a_{12}\|A_{12}\| + ... + (-1)^{n+1}a_{1n}\|A_{1n}\|\\]

Let \\(B = A^T\\), we have

\\[det(B) = b_{11}\|B_{11}\| - b_{21}\|B_{21}\| + ... + (-1)^{n+1}b_{n1}\|B_{n1}\|\\]

However, we know \\(a_{1j} = b_{j1}\\) and \\(B_{j1} = {A_{1j}}^T\\). Applying our induction hypothesis to \\((n-1)\\)st-order determinant \\(\|A_{1j}\|\\), we have \\(\|A_{1j}\| = \|B_{j1}\|\\).

We conclude \\(det(A) = det(B) = det(A^T)\\).

\\(Q.E.D.\\)

#### The Row-Interchange Property

**Theorem:** If two different rows of a square matrix \\(A\\) are interchanged, the determinant of the resulting matrix is \\(-det(A)\\)

**Proof:**

The proof for \\(n = 2\\) is trivial. Assume \\(n > 2\\), and this holds for all matrices smaller than \\(n \times n\\).

Let \\(B\\) be matrix obtained from \\(A\\) by interchanging \\(i\\)th and \\(r\\)th rows. Because \\(n > 2\\), we can choose another \\(k\\)th row for expansion. Consider these two cofactors

\\[(-1)^{k+j}\|A_{kj}\| \ \text{and} \ (-1)^{k+j}\|B_{kj}\|\\]

These numbers must have opposite signs by induction, since \\(A_{kj}\\) and \\(B_{kj}\\) have size of \\((n-1) \times (n-1)\\). Therefore we have \\(\|B_{kj}\| = -\|A_{kj}\|\\).

Expanding by minors on \\(k\\)th row will give us \\(det(A) = -det(B)\\)


\\(Q.E.D.\\)

#### The Equal-Rows Property

**Theorem:** If two rows of a square matrix \\(A\\) are equal, then \\(det(A) = 0\\).

**Proof:**

Let \\(B\\) be the matrix obtained by interchanging two equal rows of \\(A\\).

We have \\(det(B) = -det(A)\\), but \\(B = A\\), thus \\(det(A) = 0\\). `_(┐「ε:)_`

\\(Q.E.D.\\)

#### The Scalar-Multiplication Property

**Theorem:** If a single row of a square matrix \\(A\\) is multiplied by a scalar \\(r\\), the determinant of the resulting matrix is \\(r \cdot det(A)\\).

**Proof:**

Let \\(r\\) be any scalar, and let \\(B\\) be the matrix obtained from \\(A\\) by replacing the \\(k\\)th row of \\(A\\) by scalar multiple \\(r\\) of it.

Since all rows are equal except \\(k\\), we know all cofactors are equal. Thus we can conclude \\(det(B) = r \cdot det(A)\\).

\\(Q.E.D.\\)

#### The Row-Addition Property

**Theorem:** If the product of one row of a square matrix \\(A\\) by a scalar is added to a different row of \\(A\\), the determinant remain the same.

Same as above, we can see all cofactors are equal since other than \\(k\\)th row, everything else remains the same.

By expanding by minors on \\(k\\)th row, we have

\\[r \cdot det(C) + det(A)\\], and note \\(C\\) is just matrix \\(A\\) with two same rows. Thus the final answer is still \\(det(A)\\).

\\(Q.E.D.\\)

