#!/usr/bin/env python

"""This script solves the Project Euler problem "Counting fractions". The
problem is: How many elements would be contained in the set of reduced proper
fractions for d <= 1,000,000?
"""

from __future__ import division
import argparse


def main(args):
    """Counting fractions"""

    sieve = range(args.limit + 1)
    for i in range(2, args.limit + 1):
        if sieve[i] == i:
            multiple = i
            while multiple <= args.limit:
                sieve[multiple] *= (1 - 1 / i)
                multiple += i

    print(int(sum(sieve)) - 1)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Counting fractions')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=1000000, nargs='?',
        help='The limit on d')
    args = parser.parse_args()

    main(args)
