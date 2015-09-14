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
    RIGHT_FRAC = [3, 7]

    left_frac = [2, 7]

    for d in range(2, args.limit + 1):
        start_n = int(left_frac[0] / left_frac[1] * d)
        end_n = int(RIGHT_FRAC[0] / RIGHT_FRAC[1] * d) + 1
        for n in range(start_n, end_n + 1):
            if compare_fractions([n, d], RIGHT_FRAC) >= 0:
                continue
            if compare_fractions([n, d], left_frac) > 0:
                left_frac = [n, d]

    print(left_frac[0])


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

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Ordered fractions')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=1000000, nargs='?',
        help='The maximum denominator')
    args = parser.parse_args()

    main(args)
