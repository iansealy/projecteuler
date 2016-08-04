#!/usr/bin/env python

"""This script solves the Project Euler problem "Red, green or blue tiles". The
problem is: How many different ways can the black tiles in a row measuring
fifty units in length be replaced if colours cannot be mixed and at least one
coloured tile must be used?
"""

import argparse
try:
    from functools import lru_cache
except ImportError:
    from functools32 import lru_cache


def main(args):
    """Red, green or blue tiles"""

    # Constants
    BLOCK_SIZES = [2, 3, 4]

    total = 0
    for block_size in BLOCK_SIZES:
        total += ways(args.units, block_size) - 1

    print(total)


@lru_cache()
def ways(total_length, block_size):
    count = 1

    if total_length < block_size:
        return count

    for start in range(total_length - block_size + 1):
        count += ways(total_length - start - block_size, block_size)

    return count

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Red, green or blue tiles')
    parser.add_argument(
        'units', metavar='UNITS', type=int, default=50, nargs='?',
        help='The length of the row')
    args = parser.parse_args()

    main(args)
