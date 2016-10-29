#!/usr/bin/env python

"""This script solves the Project Euler problem "Same differences". The problem
is: How many values of n less than one million have exactly ten distinct
solutions?
"""

from __future__ import division
import argparse
import math
from collections import defaultdict


def main(args):
    """Same differences"""

    # y = z + d
    # x = z + 2d
    # x^2 - y^2 - z^2 = n
    # (z + 2d)^2 - (z + d)^2 - z^2 = n
    # 3d^2 + 2dz - z^2 = n
    count = defaultdict(int)
    for d in range(1, args.limit + 1):
        z = 0
        while z <= args.limit:
            z += 1
            n = 3 * d * d + 2 * d * z - z * z
            if n < 0:
                break
            if n > args.limit:
                # Solve quadratic equation to determine when back below limit
                sq_root = math.sqrt((2 * d) * (2 * d) -
                                    4 * (args.limit - 3 * d * d))
                z1 = math.floor((2 * d - sq_root) / 2)
                z2 = math.floor((2 * d + sq_root) / 2)
                if z1 > z:
                    z = z1 - 1
                elif z2 > z:
                    z = z2 - 1
                continue
            count[n] += 1

    print(len([i for i in count if count[i] == args.solutions]))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Same differences')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=1000000, nargs='?',
        help='The maximum value of n')
    parser.add_argument(
        'solutions', metavar='SOLUTIONS', type=int, default=10, nargs='?',
        help='The number of distinct solutions')
    args = parser.parse_args()

    main(args)
