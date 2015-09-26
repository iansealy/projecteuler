#!/usr/bin/env python

"""This script solves the Project Euler problem "Counting fractions in a
range". The problem is: How many fractions lie between 1/3 and 1/2 in the
sorted set of reduced proper fractions for d <= 12,000?
"""

from __future__ import division
import argparse


def main(args):
    """Counting fractions in a range"""

    # Constants
    LEFT_FRAC = [1, 3]
    RIGHT_FRAC = [1, 2]

    count = 0
    for d in range(2, args.limit + 1):
        start_n = int(LEFT_FRAC[0] / LEFT_FRAC[1] * d)
        end_n = int(RIGHT_FRAC[0] / RIGHT_FRAC[1] * d) + 1
        for n in range(start_n, end_n + 1):
            if compare_fractions([n, d], LEFT_FRAC) <= 0:
                continue
            if compare_fractions([n, d], RIGHT_FRAC) >= 0:
                break
            if gcd(n, d) == 1:
                count += 1

    print(count)


def compare_fractions(frac1, frac2):
    """Compare two fractions"""

    big_numer1 = frac1[0] * frac2[1]
    big_numer2 = frac2[0] * frac1[1]

    if big_numer1 > big_numer2:
        return(1)
    elif big_numer1 < big_numer2:
        return(-1)
    else:
        return(0)


def gcd(a, b):
    """Get greatest common divisor"""

    if a > b:
        a, b = b, a

    while a:
        a, b = b % a, a

    return(b)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Counting fractions in a range')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=12000, nargs='?',
        help='The limit on d')
    args = parser.parse_args()

    main(args)
