#!/usr/bin/env python

"""This script solves the Project Euler problem "Red, green, and blue tiles".
The problem is: How many ways can a row measuring fifty units in length be
tiled?
"""

import argparse
try:
    from functools import lru_cache
except ImportError:
    from functools32 import lru_cache


def main(args):
    """Red, green, and blue tiles"""

    # Constants
    global BLOCK_SIZES
    BLOCK_SIZES = [2, 3, 4]

    print(ways(args.units))


@lru_cache()
def ways(total_length):
    count = 1

    if total_length < BLOCK_SIZES[0]:
        return count

    for block_size in BLOCK_SIZES:
        for start in range(total_length - block_size + 1):
            count += ways(total_length - start - block_size)

    return count

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Red, green, and blue tiles')
    parser.add_argument(
        'units', metavar='UNITS', type=int, default=50, nargs='?',
        help='The length of the row')
    args = parser.parse_args()

    main(args)
