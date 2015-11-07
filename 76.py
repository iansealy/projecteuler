#!/usr/bin/env python

"""This script solves the Project Euler problem "Counting summations". The
problem is: How many different ways can one hundred be written as a sum of at
least two positive integers?
"""

from __future__ import division
import argparse
try:
    from functools import lru_cache
except ImportError:
    from functools32 import lru_cache


def main(args):
    """Counting summations"""

    print(partitions(args.number) - 1)


@lru_cache()
def partitions(n):

    if n == 0:
        return(1)

    parts = 0
    k = 1
    while True:
        pent = pentagonal(k)
        if n - pent < 0:
            break
        parts += int(pow(-1, k - 1)) * partitions(n - pent)
        if k > 0:
            k = -k
        else:
            k = -k + 1

    return(parts)


@lru_cache()
def pentagonal(n):
    return((3 * n * n - n) // 2)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Counting summations')
    parser.add_argument(
        'number', metavar='NUMBER', type=int, default=100, nargs='?',
        help='The number to express as sums')
    args = parser.parse_args()

    main(args)
