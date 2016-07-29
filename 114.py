#!/usr/bin/env python

"""This script solves the Project Euler problem "Counting block combinations
I". The problem is: How many ways can a row measuring fifty units in length be
filled?
"""

import argparse
try:
    from functools import lru_cache
except ImportError:
    from functools32 import lru_cache


def main(args):
    """Counting block combinations I"""

    # Constants
    global MIN_BLOCK
    MIN_BLOCK = 3

    print(ways(args.units))


@lru_cache()
def ways(total_length):
    count = 1

    if total_length < MIN_BLOCK:
        return count

    for start in range(total_length - MIN_BLOCK + 1):
        for block_length in range(MIN_BLOCK, total_length - start + 1):
            count += ways(total_length - start - block_length - 1)

    return count

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Counting block combinations I')
    parser.add_argument(
        'units', metavar='UNITS', type=int, default=50, nargs='?',
        help='The length of the row')
    args = parser.parse_args()

    main(args)
