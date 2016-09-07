#!/usr/bin/env python

"""This script solves the Project Euler problem "Prime square remainders". The
problem is: Find the least value of n for which the remainder first exceeds
10^10.
"""

from __future__ import division
import argparse
import math


def main(args):
    """Prime square remainders"""

    primes = get_primes_up_to(int(math.sqrt(args.limit) * 10))

    n = 0
    for prime in primes:
        n += 1
        if n % 2 == 0:
            continue
        r = prime * n * 2
        if r > args.limit:
            break

    print(n)


def get_primes_up_to(limit):
    """Get all primes up to specified limit"""

    sieve_bound = (limit - 1) // 2  # Last index of sieve
    sieve = [False for _ in range(sieve_bound)]
    cross_limit = (math.sqrt(limit) - 1) // 2

    i = 1
    while i <= cross_limit:
        if not sieve[i - 1]:
            # 2 * $i + 1 is prime, so mark multiples
            j = 2 * i * (i + 1)
            while j <= sieve_bound:
                sieve[j - 1] = True
                j += 2 * i + 1
        i += 1

    primes = [2 * n + 1 for n in range(1, sieve_bound + 1) if not sieve[n - 1]]
    primes.insert(0, 2)

    return(primes)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Prime square remainders')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=10000000000, nargs='?',
        help='The minimum remainder')
    args = parser.parse_args()

    main(args)
