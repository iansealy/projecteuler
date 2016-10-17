#!/usr/bin/env python

"""This script solves the Project Euler problem "Large repunit factors". The
problem is: Find the sum of the first forty prime factors of R(10^9).
"""

from __future__ import division
import argparse
import math


def main(args):
    """Large repunit factors"""

    limit = 1000
    factors = []
    while len(factors) < args.factors:
        factors = []
        limit *= 10
        primes = get_primes_up_to(limit)
        for prime in primes:
            if modular_exponentiation(10, args.k, 9 * prime) == 1:
                factors.append(prime)
                if len(factors) == args.factors:
                    break

    print(sum(factors))


def modular_exponentiation(base, exp, mod):
    """Get modulus of base to the power of exponent"""

    result = 1
    base %= mod
    while exp > 0:
        if exp % 2 == 1:
            result = (result * base) % mod
        exp >>= 1
        base = (base * base) % mod

    return result


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
    parser = argparse.ArgumentParser(description='Large repunit factors')
    parser.add_argument(
        'k', metavar='K', type=int, default=10**9, nargs='?',
        help='The number of digits in the repunit')
    parser.add_argument(
        'factors', metavar='FACTORS', type=int, default=40, nargs='?',
        help='The number of prime factors to sum')
    args = parser.parse_args()

    main(args)
