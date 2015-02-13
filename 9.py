#!/usr/bin/env python

"""This script solves the Project Euler problem "Special Pythagorean triplet".
The problem is: There exists exactly one Pythagorean triplet for which
a + b + c = 1000. Find the product abc.
"""

import math


def main():
    """Special Pythagorean triplet"""

    # Constants
    SUM = 1000

    a, b, c = get_pythagorean_triplet_by_sum(SUM)

    print(a * b * c)


def get_pythagorean_triplet_by_sum(target_sum):
    """Get Pythagorean triplet"""

    a = 1
    while a < target_sum - 2:
        b = a + 1
        while b < target_sum - 1:
            c = math.sqrt(a * a + b * b)
            # Check if we have a Pythagorean triplet
            if int(c) == c:
                if a + b + c == target_sum:
                    return a, b, int(c)
            b += 1
        a += 1
    return(0, 0, 0)

if __name__ == '__main__':
    main()
