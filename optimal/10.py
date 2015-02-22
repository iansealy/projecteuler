#!/usr/bin/env python

"""This script solves the Project Euler problem "Summation of primes". The
problem is: Find the sum of all the primes below two million.
"""

from __future__ import division
import argparse
import math


def main(args):
    """Summation of primes"""

    sieve_bound = (args.limit - 1) // 2  # Last index of sieve
    sieve = [False for _ in range(sieve_bound)]
    cross_limit = (math.sqrt(args.limit) - 1) // 2

    i = 1
    while i <= cross_limit:
        if not sieve[i - 1]:
            # 2 * $i + 1 is prime, so mark multiples
            j = 2 * i * (i + 1)
            while j <= sieve_bound:
                sieve[j - 1] = True
                j += 2 * i + 1
        i += 1

    sum = 2  # 2 is a prime
    i = 1
    while i <= sieve_bound:
        if not sieve[i - 1]:
            sum += 2 * i + 1
        i += 1

    print(sum)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Summation of primes')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=2000000, nargs='?',
        help='The number below which to sum up all primes')
    args = parser.parse_args()

    main(args)
