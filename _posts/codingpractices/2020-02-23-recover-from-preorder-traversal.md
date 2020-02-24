---
layout: post
title: Recover From Preorder Traversal
date: 2020-02-23 10:26:00 -0400
tags: codingpractices
category: codingpractices
language: Java
type: LC Hard
---

The actual question can be found [here](https://leetcode.com/problems/recover-a-tree-from-preorder-traversal/)

```java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
class Solution {
    public TreeNode recoverFromPreorder(String S) {
        // This is a recursive solution
        if(S.length() == 0) return null;
        if(!S.contains("-")) {
            return new TreeNode(Integer.parseInt(S));
        } else {
            int numericStartingIndex = 0;
            String rootVal = "";
            for(int i = 0; i < S.length(); i++) {
                if(S.charAt(i) == '-') {
                    numericStartingIndex = i;
                    break;
                } else {
                    rootVal += S.charAt(i);
                }
            }
            TreeNode node = new TreeNode(Integer.parseInt(rootVal));
            
            boolean foundDepthOne = false;
            int currDepth = 0;
            boolean atRight = false;
            String left = "";
            String right = "";
            for(int i = numericStartingIndex; i < S.length(); i++) {
                if(S.charAt(i) == '-') {
                    currDepth++;
                } else {
                    char value = S.charAt(i);
                    // If this depth is the same or less than max depth
                    // then we have to switch from left to right
                    if(currDepth == 1) {
                        if(!foundDepthOne) {
                            foundDepthOne = true;
                        } else {
                            atRight = true;
                        }
                    }
                    if(atRight) {
                        right = addNodeToString(right, value, currDepth - 1);
                    } else {
                        left = addNodeToString(left, value, currDepth - 1);
                    }
                    currDepth = 0;
                }
            }
            node.left = recoverFromPreorder(left);
            node.right = recoverFromPreorder(right);
            return node;
        }
    }
    
    public String addNodeToString(String curr, char value, int depth) {
        for(int i = 0; i < depth; i++) {
            curr += '-';
        }
        curr += value;
        return curr;
    }
}
```