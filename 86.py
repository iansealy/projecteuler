#!/usr/bin/env python

"""This script solves the Project Euler problem "Cuboid route". The problem is:
Find the least value of M such that the number of solutions first exceeds one
million.
"""

from __future__ import division
import argparse
import math


def main(args):
    """Cuboid route"""

    total = 0
    m = 1
    while total < args.target:
        for ij in range(1, 2 * m + 1):
            route = math.sqrt(ij * ij + m * m)
            if int(route) == route:
                if ij <= m:
                    total += ij // 2
                else:
                    total += m - (ij + 1) // 2 + 1
        m += 1

    print(m - 1)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Cuboid route')
    parser.add_argument(
        'target', metavar='TARGET', type=int, default=1000000, nargs='?',
        help='The target number of distinct cuboids')
    args = parser.parse_args()

    main(args)
