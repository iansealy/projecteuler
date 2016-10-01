#!/usr/bin/env python

"""This script solves the Project Euler problem "Hexagonal tile differences".
The problem is: Find the 2000th tile in this sequence.
"""

import argparse
import math


def main(args):
    """Hexagonal tile differences"""

    tile = 2
    ring = 1
    count = 2  # PD(1) = 3 & PD(2) = 3
    while True:
        ring += 1

        # Top tile
        tile = top(ring)
        neighbours = [
            top(ring + 1),
            top(ring + 1) + 1,
            top(ring) + 1,
            top(ring - 1),
            top(ring + 1) - 1,
            top(ring + 2) - 1,
        ]
        count += pd(tile, neighbours) == 3
        if count == args.ordinal:
            break

        # Last tile
        tile = top(ring + 1) - 1
        neighbours = [
            top(ring + 2) - 1,
            top(ring),
            top(ring - 1),
            top(ring) - 1,
            top(ring + 1) - 2,
            top(ring + 2) - 2,
        ]
        count += pd(tile, neighbours) == 3
        if count == args.ordinal:
            break

    print(tile)


def top(ring):
    """Get ordinal of top tile in ring"""

    return 3 * ring * ring - 3 * ring + 2


def pd(centre, neighbours):
    """Count number of prime differences"""

    return sum([is_prime(abs(centre - neighbour)) for neighbour in neighbours])


def is_prime(num):
    """Test if number is prime"""

    if num == 1:      # 1 isn't prime
        return False
    if num < 4:       # 2 and 3 are prime
        return True
    if num % 2 == 0:  # Even numbers aren't prime
        return False
    if num < 9:       # 5 and 7 are prime
        return True
    if num % 3 == 0:  # Numbers divisible by 3 aren't prime
        return False

    num_sqrt = int(math.sqrt(num))
    factor = 5
    while factor <= num_sqrt:
        if num % factor == 0:        # Primes greater than three are 6k-1
            return False
        if num % (factor + 2) == 0:  # Or 6k+1
            return False
        factor += 6
    return True

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Hexagonal tile differences')
    parser.add_argument(
        'ordinal', metavar='ORDINAL', type=int, default=2000, nargs='?',
        help='The required ordinal of the sequence')
    args = parser.parse_args()

    main(args)
