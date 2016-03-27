#!/usr/bin/env python

"""This script solves the Project Euler problem "Almost equilateral triangles".
The problem is: Find the sum of the perimeters of all almost equilateral
triangles with integral side lengths and area and whose perimeters do not
exceed one billion (1,000,000,000).
"""


def main():
    """Almost equilateral triangles"""

    # Constants
    MAX = 1e9

    total = 0

    m = 1
    below_max = True
    while below_max:
        m += 1
        m2 = m * m
        n = - 1
        if m % 2:
            n = 0
        while n < m - 2:
            n += 2
            n2 = n * n
            a = m2 - n2
            b = 2 * m * n
            c = m2 + n2
            if abs(2 * a - c) != 1 and abs(2 * b - c) != 1:
                continue
            if 2 * (a + c) > MAX and 2 * (b + c) > MAX:
                below_max = False
                break
            if abs(2 * a - c) == 1:
                total += 2 * (a + c)
            elif abs(2 * b - c) == 1:
                total += 2 * (b + c)

    print(total)

if __name__ == '__main__':
    main()
