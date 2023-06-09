---
title: "Rabin Karp Search"
date: 2021-12-23T14:58:00+08:00
lastmod: 2021-12-23T14:58:00+08:00
draft: false
categories:
  - "算法"
tags:
  - "算法"
author: "何年重遇天涯"
contentCopyright: '<a rel="license noopener" href="https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License" target="_blank">Creative Commons Attribution-ShareAlike License</a>'
---
Rabin Karp Search字符串快速搜索算法
<!--more-->
## 算法
```cpp
#include <iostream>
#include <string>

using namespace std;

void Rabin_Karp_search(const string &T, const string &P, int d, int q)
{
    int m = P.length();
    int n = T.length();
    int i, j;
    int p = 0; // hash value for pattern
    int t = 0; // hash value for txt
    int h = 1;

    // The value of h would be "pow(d, M-1)%q"
    for (i = 0; i < m - 1; i++)
        h = (h * d) % q;

    // Calculate the hash value of pattern and first window of text
    for (i = 0; i < m; i++)
    {
        p = (d * p + P[i]) % q;
        t = (d * t + T[i]) % q;
    }

    // Slide the pattern over text one by one
    for (i = 0; i <= n - m; i++)
    {

        // Chaeck the hash values of current window of text and pattern
        // If the hash values match then only check for characters on by one
        if (p == t)
        {
            /* Check for characters one by one */
            for (j = 0; j < m; j++)
                if (T[i + j] != P[j])
                    break;

            if (j == m) // if p == t and pat[0...M-1] = txt[i, i+1, ...i+M-1]
                cout << "Pattern found at index :" << i << endl;
        }

        // Calulate hash value for next window of text: Remove leading digit,
        // add trailing digit
        if (i < n - m)
        {
            t = (d * (t - T[i] * h) + T[i + m]) % q;

            // We might get negative value of t, converting it to positive
            if (t < 0)
                t = (t + q);
        }
    }
}

int main()
{
    string T = "Rabin–Karp string search algorithm: Rabin-Karp";
    string P = "Rabin";
    int q = 101; // A prime number
    int d = 16;
    Rabin_Karp_search(T, P, d, q);
    return 0;
}
```