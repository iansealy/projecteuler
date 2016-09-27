#!/usr/bin/env python

"""This script solves the Project Euler problem "abc-hits". The problem is:
Find sum c for c < 120000.
"""

import argparse
import math


def main(args):
    """abc-hits"""

    radicals = [1] * (args.limit + 1)
    for n in range(2, args.limit + 1):
        if radicals[n] == 1:
            radicals[n] = n
            multiple = n + n
            while multiple <= args.limit:
                radicals[multiple] *= n
                multiple += n

    indices = list(range(1, args.limit + 1))
    indices.sort(key=lambda i: radicals[i])

    pairs = set()
    for c in indices:
        rad_a_or_b_limit = math.floor(math.sqrt(c / radicals[c]))
        for a_or_b in indices:
            if radicals[a_or_b] > rad_a_or_b_limit:
                break
            if a_or_b >= c:
                continue
            a = a_or_b
            b = c - a_or_b
            if a > b:
                a, b = b, a
            if radicals[a] * radicals[b] * radicals[c] >= c:
                continue
            if gcd(a, b) > 1:
                continue
            pairs.add((a, b))

    print(sum(a + b for a, b in pairs))


def gcd(a, b):
    """Get greatest common divisor"""

    if a > b:
        a, b = b, a

    while a:
        a, b = b % a, a

    return(b)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='abc-hits')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=120000, nargs='?',
        help='The maximum value of c')
    args = parser.parse_args()

    main(args)
