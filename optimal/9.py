#!/usr/bin/env python

"""This script solves the Project Euler problem "Special Pythagorean triplet".
The problem is: There exists exactly one Pythagorean triplet for which
a + b + c = 1000. Find the product abc.
"""

from __future__ import division
import math


def main():
    """Special Pythagorean triplet"""

    # Constants
    SUM = 1000

    a, b, c = get_pythagorean_triplet_by_sum(SUM)

    print(a * b * c)


def get_pythagorean_triplet_by_sum(s):
    """Get Pythagorean triplet"""

    s2 = s // 2
    mlimit = int(math.ceil(math.sqrt(s2))) - 1
    for m in range(2, mlimit + 1):
        if s2 % m == 0:
            sm = s2 // m
            while sm % 2 == 0:
                sm = sm // 2
            k = m + 1
            if m % 2 == 1:
                k = m + 2
            while k < 2 * m and k <= sm:
                if sm % k == 0 and gcd(k, m) == 1:
                    d = s2 // (k * m)
                    n = k - m
                    a = d * (m * m - n * n)
                    b = 2 * d * m * n
                    c = d * (m * m + n * n)
                    return(a, b, c)
                k += 2
    return(0, 0, 0)


def gcd(a, b):
    """Get greatest common divisor"""

    if a > b:
        a, b = b, a

    while a:
        a, b = b % a, a

    return(b)

if __name__ == '__main__':
    main()
