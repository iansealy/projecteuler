#!/usr/bin/env python

"""This script solves the Project Euler problem "Distinct primes factors". The
problem is: Find the first four consecutive integers to have four distinct
prime factors. What is the first of these numbers?
"""

import argparse


def main(args):
    """Distinct primes factors"""

    limit = 100
    first = None
    while first is None:
        limit *= 10
        sieve = [0 for _ in range(limit)]
        consecutive = 0
        i = 1
        while i < limit:
            i += 1
            if not sieve[i - 2]:
                j = 2 * i
                while j <= limit:
                    sieve[j - 2] += 1
                    j += i
            if sieve[i - 2] == args.target:
                consecutive += 1
                if consecutive == args.target:
                    first = i - args.target + 1
                    break
            else:
                consecutive = 0

    print(first)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Distinct primes factors')
    parser.add_argument(
        'target', metavar='TARGET', type=int, default=4, nargs='?',
        help='The target number of consecutive integers and prime factors')
    args = parser.parse_args()

    main(args)
