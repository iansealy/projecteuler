#!/usr/bin/env python

"""This script solves the Project Euler problem "Ordered radicals". The problem
is: If rad(n) is sorted for 1 <= n <= 100000, find E(10000).
"""

import argparse


def main(args):
    """Ordered radicals"""

    radicals = [1] * (args.limit + 1)
    for n in range(2, args.limit + 1):
        if radicals[n] == 1:
            radicals[n] = n
            multiple = n + n
            while multiple <= args.limit:
                radicals[multiple] *= n
                multiple += n

    indices = list(range(1, args.limit + 1))
    indices.sort(key=lambda i: radicals[i] or i)

    print(indices[args.ordinal - 1])

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Ordered radicals')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=100000, nargs='?',
        help='The maximum value of n')
    parser.add_argument(
        'ordinal', metavar='ORDINAL', type=int, default=10000, nargs='?',
        help='The required ordinal')
    args = parser.parse_args()

    main(args)
