#!/usr/bin/env python

"""This script solves the Project Euler problem "Counting block combinations
II". The problem is: For m = 50, find the least value of n for which the
fill-count function first exceeds one million.
"""

import argparse
try:
    from functools import lru_cache
except ImportError:
    from functools32 import lru_cache


def main(args):
    """Counting block combinations II"""

    # Constants
    TARGET = 1000000

    n = args.m + 1
    while ways(args.m, n) <= TARGET:
        n += 1

    print(n)


@lru_cache()
def ways(min_block, total_length):
    count = 1

    if total_length < min_block:
        return count

    for start in range(total_length - min_block + 1):
        for block_length in range(min_block, total_length - start + 1):
            count += ways(min_block, total_length - start - block_length - 1)

    return count

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Counting block combinations II')
    parser.add_argument(
        'm', metavar='M', type=int, default=50, nargs='?',
        help='Minimum block length')
    args = parser.parse_args()

    main(args)
