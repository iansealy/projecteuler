#!/usr/bin/env python

"""This script solves the Project Euler problem "Cuboid route". The problem is:
Find the first four consecutive integers to have four distinct
prime factors. What is the first of these numbers?
"""

import argparse
import math


def main(args):
    """Cuboid route"""

    total = 0
    m = 1
    while total < args.target:
        for i in range(1, m + 1):
            for j in range(i, m + 1):
                route = math.sqrt((i + j) * (i + j) + m * m)
                if int(route) == route:
                    total += 1
        m += 1

    print(m - 1)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Cuboid route')
    parser.add_argument(
        'target', metavar='TARGET', type=int, default=1000000, nargs='?',
        help='The target number of distinct cuboids')
    args = parser.parse_args()

    main(args)
