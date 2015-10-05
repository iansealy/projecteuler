#!/usr/bin/env python

"""This script solves the Project Euler problem "Singular integer right
triangles". The problem is: Given that L is the length of the wire, for how
many values of L <= 1,500,000 can exactly one integer sided right angle
triangle be formed?
"""

import math
from collections import defaultdict


def main():
    """Singular integer right triangles"""

    # Constants
    LIMIT = 1500000

    count = defaultdict(int)
    mlimit = int(math.floor(math.sqrt(LIMIT)))
    for m in range(2, mlimit + 1):
        for n in range(1, m):
            if (m + n) % 2 == 0 or gcd(n, m) > 1:
                continue
            length = 2 * m * (m + n)
            multiple = length
            while multiple <= LIMIT:
                count[multiple] += 1
                multiple += length

    print(len(list(value for value in count.values() if value == 1)))


def gcd(a, b):
    """Get greatest common divisor"""

    if a > b:
        a, b = b, a

    while a:
        a, b = b % a, a

    return(b)

if __name__ == '__main__':
    main()
