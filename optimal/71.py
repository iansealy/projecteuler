#!/usr/bin/env python

"""This script solves the Project Euler problem "Ordered fractions". The
problem is: By listing the set of reduced proper fractions for d <= 1,000,000
in ascending order of size, find the numerator of the fraction immediately to
the left of 3/7.
"""

from __future__ import division
import argparse


def main(args):
    """Ordered fractions"""

    # Constants
    TARGET_FRAC = [3, 7]

    best_numer = 0
    best_denom = 1
    cur_denom = args.limit
    min_denom = 1
    while cur_denom >= min_denom:
        cur_numer = (TARGET_FRAC[0] * cur_denom - 1) // TARGET_FRAC[1]
        if best_numer * cur_denom < cur_numer * best_denom:
            best_numer = cur_numer
            best_denom = cur_denom
            delta = TARGET_FRAC[0] * cur_denom - TARGET_FRAC[1] * cur_numer
            min_denom = cur_denom // delta + 1
        cur_denom -= 1

    print(best_numer)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Ordered fractions')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=1000000, nargs='?',
        help='The maximum denominator')
    args = parser.parse_args()

    main(args)
