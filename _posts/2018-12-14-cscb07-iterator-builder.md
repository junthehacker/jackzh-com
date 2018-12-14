---
layout: post
title: CSCB07 Software Design - Iterator and Builder Pattern
date: 2018-12-14 15:06:00 -0400
tags: cscb07 course-notes
category: cscb07
---

Course notes taken for CSCB07/CSC207 at UofT (Software Design).

Iterator and Builder design pattern.

<!--more-->

## Iterator Pattern

Iterator pattern allows traversal of the elements of a collection without exposing the underlying implementation.

To use iterator pattern, we can utilize Java's `Iterator` interface.

```java
class MyIterator implements Iterator {
    public Object next() {

    }
    
    public boolean hasNext() {

    }
}
```

Then we simply construct this iterator within the actual class.

There is also `Iterable` interface

```java
package vector;

import java.util.Iterator;
import util.NumberFormatter;
import vector.exceptions.IncompatibleVectorTypeException;
import vector.exceptions.InvalidIndexException;
import vector.exceptions.InvalidVectorSizeException;

/**
 * An vector contains real numbers.
 */
public class RealVector implements IVector, Iterable<Number> {

  /**
   * Stores all data.
   */
  private Number[] data;

  /**
   * Get the iterator.
   *
   * @return The number iterator.
   */
  @Override
  public Iterator<Number> iterator() {
    return new Iterator<Number>() {

      /**
       * Current iterator index.
       */
      private int currentIndex = 0;

      /**
       * If iterator has next item.
       * @return True if has next item.
       */
      @Override
      public boolean hasNext() {
        return currentIndex != data.length;
      }

      /**
       * Get iterator next item.
       * @return Next item.
       */
      @Override
      public Number next() {
        int tmp = currentIndex;
        currentIndex++;
        return data[tmp];
      }
    };
  }
}
```

## Nested Classes

It is a good way to group classes that are only used in one place.

Nesting helper classes can make package more streamlined.

It also increases encapsulation and creates more readable and maintainable code.

### Static / Non-Static

Nested classes that are declared static are called static nested classes.

Non-static nested classes are called inner classes.

Static nested class is really just a class, but for package organizing convinence.

## Builder Pattern

Consider builder when have a lot of constructor parameters.

Static factories and constructors have problems:
* Does not work well with large number of optional parameters.

Advantage of builder:
* Very easy to read and write.
* Can simulate named optional params in python.
* The class is immutable!

Sample builder directly taken from A3

```java
package cfiltering;

import io.IOutputIO;
import io.StreamOutputIO;
import matrix.RealMatrix;
import matrix.RealSquareMatrix;
import matrix.comparator.ComparisonType;
import matrix.comparator.DistanceComparator;
import parser.IParser;
import util.NumberFormatter;
import util.SimilarityScore;

/**
 * Filtering instance, calculates all scores.
 */
public class CFilter {

  /**
   * Used to parse files to matrix.
   */
  private final IParser matrixParser;

  /**
   * Used to write output content.
   */
  private IOutputIO outputStream;

  /**
   * User movie rating matrix.
   */
  private RealMatrix userMovieMatrix;

  /**
   * Similarity score matrix.
   */
  private RealSquareMatrix userUserMatrix;

  /**
   * Create a new filter instance.
   *
   * @param b Builder instance.
   * @throws Exception When fatal error.
   */
  private CFilter(Builder b) throws Exception {
    this.matrixParser = b.matrixParser;
    this.outputStream = b.outputStream;
    this.userMovieMatrix = (RealMatrix) matrixParser.parse();
    this.userUserMatrix = SimilarityScore
        .calculateSimilarityMatrix(this.userMovieMatrix);
  }

  /**
   * Print the result of this filtering.
   *
   * @throws Exception When fatal error.
   */
  public void print() throws Exception {
    // Print userUserMatrix
    this.outputStream.write(userUserMatrix.toString() + "\n\n");

    // Print most similar pairs
    int[][] pairs = DistanceComparator
        .findPairs(userUserMatrix, ComparisonType.MAX);
    this.outputStream.writeLine("The most similar pairs of users from "
        + "above userUserMatrix are:");
    String result = "";
    for (int[] pair : pairs) {
      UserPair userPair = new UserPair(pair);
      result += userPair.toString();
    }
    result =
        result.substring(0, result.length() - 2) + "\nwith similarity score of "
            +
            NumberFormatter.formatFloatForPrinting(
                (float) userUserMatrix.getValue(pairs[0][0], pairs[0][1]))
            + "\n\n\n";
    this.outputStream.write(result);

    // Print most dissimilar pairs
    pairs = DistanceComparator.findPairs(userUserMatrix, ComparisonType.MIN);
    this.outputStream.writeLine("The most dissimilar pairs of users from "
        + "above userUserMatrix are:");
    result = "";
    for (int[] pair : pairs) {
      UserPair userPair = new UserPair(pair);
      result += userPair.toString();
    }
    result =
        result.substring(0, result.length() - 2) + "\nwith similarity score of "
            +
            NumberFormatter.formatFloatForPrinting(
                (float) userUserMatrix.getValue(pairs[0][0], pairs[0][1]))
            + "\n\n\n";
    this.outputStream.write(result);
  }

  /**
   * Builder class.
   */
  public static class Builder {

    /**
     * Used to parse file to matrix.
     */
    private final IParser matrixParser;

    /**
     * Used to write outputs.
     */
    private IOutputIO outputStream;

    /**
     * Create a new builder instance.
     *
     * @param matrixParser Parser instance to use.
     */
    public Builder(IParser matrixParser) {
      this.matrixParser = matrixParser;
      // Default values.
      this.outputStream = StreamOutputIO.createWithStdOut();
    }

    /**
     * Set output stream.
     *
     * @param outputStream Stream to use.
     * @return The builder.
     */
    public Builder outputStream(IOutputIO outputStream) {
      this.outputStream = outputStream;
      return this;
    }

    /**
     * Build the filtering instance.
     *
     * @return Built instance.
     * @throws Exception When fatal error.
     */
    public CFilter build() throws Exception {
      return new CFilter(this);
    }

  }
}
```