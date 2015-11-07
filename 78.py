#!/usr/bin/env python

"""This script solves the Project Euler problem "Coin partitions". The problem
is: Find the least value of n for which p(n) is divisible by one million.
"""

from __future__ import division
import argparse
try:
    from functools import lru_cache
except ImportError:
    from functools32 import lru_cache


def main(args):
    """Coin partitions"""

    n = 1
    while partitions(n):
        n += 1

    print(n)


@lru_cache(maxsize=None)
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
        parts = parts % args.divisor
        if k > 0:
            k = -k
        else:
            k = -k + 1

    return(parts)


@lru_cache(maxsize=None)
def pentagonal(n):
    return((3 * n * n - n) // 2)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Coin partitions')
    parser.add_argument(
        'divisor', metavar='DIVISOR', type=int, default=1000000, nargs='?',
        help='The target divisor')
    args = parser.parse_args()

    main(args)
