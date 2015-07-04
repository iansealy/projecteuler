#!/usr/bin/env python

"""This script solves the Project Euler problem "Consecutive prime sum". The
problem is: Which prime, below one-million, can be written as the sum of the
most consecutive primes?
"""

from __future__ import division
import argparse
import math


def main(args):
    """Consecutive prime sum"""

    primes = get_primes_up_to(args.limit - 1)
    is_prime = {prime: True for prime in primes}

    max_consecutive = 0
    max_prime = None
    while primes:
        total = 0
        for i, prime in enumerate(primes, start=1):
            total += prime
            if total > args.limit:
                break
            if total in is_prime and i > max_consecutive:
                max_consecutive = i
                max_prime = total
        primes.pop(0)

    print(max_prime)


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
    parser = argparse.ArgumentParser(description='Consecutive prime sum')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=1000000, nargs='?',
        help='The limit on the highest prime')
    args = parser.parse_args()

    main(args)
