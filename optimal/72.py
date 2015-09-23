#!/usr/bin/env python

"""This script solves the Project Euler problem "Counting fractions". The
problem is: How many elements would be contained in the set of reduced proper
fractions for d <= 1,000,000?
"""

from __future__ import division
import argparse
import math


def main(args):
    """Counting fractions"""

    sieve_limit = (int(math.sqrt(args.limit)) - 1) // 2
    max_index = (args.limit - 1) // 2
    cache = [0] * (max_index + 1)
    for n in range(1, sieve_limit + 1):
        if cache[n] == 0:
            p = 2 * n + 1
            for k in range(2 * n * (n + 1), max_index + 1, p):
                if cache[k] == 0:
                    cache[k] = p
    multipler = 1
    while multipler <= args.limit:
        multipler *= 2
    multipler //= 2
    count = multipler - 1
    multipler //= 2
    step_index = ((args.limit // multipler) + 1) // 2
    for n in range(1, max_index + 1):
        if n == step_index:
            multipler //= 2
            step_index = ((args.limit // multipler) + 1) // 2
        if cache[n] == 0:
            cache[n] = 2 * n
            count += multipler * cache[n]
        else:
            p = cache[n]
            cofactor = (2 * n + 1) // p
            factor = p
            if cofactor % p:
                factor = p - 1
            cache[n] = factor * cache[cofactor // 2]
            count += multipler * cache[n]

    print(count)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Counting fractions')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=1000000, nargs='?',
        help='The limit on d')
    args = parser.parse_args()

    main(args)
