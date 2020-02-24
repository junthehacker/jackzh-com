---
layout: post
title: Word Break II
date: 2020-02-24 18:12:00 -0400
tags: codingpractices
category: codingpractices
language: Python
type: LC Hard
---

The main optimization for this is the memo. Because the problem is recursive, we simply remember the result of sub-problems.

Actual problem can be found [here](https://leetcode.com/problems/word-break-ii/).

```python
class Solution:
    def wordBreak(self, s: str, wordDict: List[str]) -> List[str]:
        self.memo = {}
        return self.recursiveSolution(0, len(s), s, set(wordDict))
    
    def recursiveSolution(self, start, end, s, wordSet):
        # Find all valid prefixes
        if start in self.memo:
            return self.memo[start]
        result = []
        for i in range(start, end + 1):
            if s[start:i] in wordSet:
                # print(str(i) + " " + str(len(s)) + " " + s + " " + s[i:] + " " + s[:i])
                if i == end:
                    result.append(s[start:])
                else:
                    subResult = self.recursiveSolution(i, end, s, wordSet)
                    for sub in subResult:
                        result.append(s[start:i] + ' ' + sub)
        self.memo[start] = result
        return result

```