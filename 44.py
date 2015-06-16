#!/usr/bin/env python

"""This script solves the Project Euler problem "Pentagon numbers". The problem
is: Find the pair of pentagonal numbers, Pj and Pk, for which their sum and
difference are pentagonal and D = |Pk - Pj| is minimised; what is the value of
D?
"""

from __future__ import division


def main():
    """Pentagon numbers"""

    is_pentagonal = {1: True}
    pentagons = [1]
    diff = 0
    n = 1
    while not diff:
        n += 1
        next_pentagon = n * (3 * n - 1) // 2
        for pentagon in pentagons:
            candidate = next_pentagon - pentagon
            candidate_diff = abs(pentagon - candidate)
            if candidate in is_pentagonal and candidate_diff in is_pentagonal:
                diff = candidate_diff
        pentagons.insert(0, next_pentagon)
        is_pentagonal[next_pentagon] = True

    print(diff)

if __name__ == '__main__':
    main()
