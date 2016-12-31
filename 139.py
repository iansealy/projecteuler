#!/usr/bin/env python

"""This script solves the Project Euler problem "Pythagorean tiles". The
problem is: Given that the perimeter of the right triangle is less than
one-hundred million, how many Pythagorean triangles would allow such a tiling
to take place?
"""

import math


def main():
    """Pythagorean tiles"""

    # Constants
    LIMIT = 100000000

    count = 0
    mlimit = int(math.floor(math.sqrt(LIMIT)))
    for m in range(2, mlimit + 1):
        m2 = m * m
        for n in range(1, m):
            if (m + n) % 2 == 0 or gcd(n, m) > 1:
                continue
            n2 = n * n
            a = m2 - n2
            b = 2 * m * n
            c = m2 + n2
            perimeter = a + b + c
            if perimeter >= LIMIT:
                break
            if c % (b - a):
                continue
            multiple = perimeter
            while multiple <= LIMIT:
                count += 1
                multiple += perimeter

    print(count)


def gcd(a, b):
    """Get greatest common divisor"""

    if a > b:
        a, b = b, a

    while a:
        a, b = b % a, a

    return(b)

if __name__ == '__main__':
    main()
