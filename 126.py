#!/usr/bin/env python

"""This script solves the Project Euler problem "Cuboid layers". The problem
is: Find the least value of n for which C(n) = 1000.
"""

from __future__ import division
import argparse
import sys

if sys.version_info[0] < 3:
    range = xrange


def main(args):
    """Cuboid layers"""

    first = None
    limit = args.cuboids * 10
    while first is None:
        limit *= 2
        count = [0] * limit
        for x in range(1, limit + 1):
            if count_cuboids(x, 1, 1, 1) >= limit:
                break
            for y in range(1, x + 1):
                if count_cuboids(x, y, 1, 1) >= limit:
                    break
                for z in range(1, y + 1):
                    if count_cuboids(x, y, z, 1) >= limit:
                        break
                    for n in range(1, limit + 1):
                        total = count_cuboids(x, y, z, n)
                        if total >= limit:
                            break
                        count[total] += 1
        try:
            first = count.index(args.cuboids)
        except ValueError:
            continue

    print(first)


def count_cuboids(x, y, z, n):
    """Count cuboids"""

    faces = 2 * (x * y + y * z + z * x)
    lines = (n - 1) * 4 * (x + y + z)
    corners = (n - 2) * (n - 1) // 2 * 8

    return faces + lines + corners

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Cuboid layers')
    parser.add_argument(
        'cuboids', metavar='CUBOIDS', type=int, default=1000, nargs='?',
        help='The number of cuboids')
    args = parser.parse_args()

    main(args)
