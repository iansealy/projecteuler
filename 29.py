#!/usr/bin/env python

"""This script solves the Project Euler problem "Distinct powers". The
problem is: How many distinct terms are in the sequence generated by a^b for 2
<= a <= 100 and 2 <= b <= 100?
"""

from __future__ import division
import math
import argparse


def main(args):
    """Distinct powers"""

    primes = get_primes_up_to(args.max)
    terms = set()
    for a in range(2, args.max + 1):
        a_factors = get_prime_factors(a, primes)
        for b in range(2, args.max + 1):
            factors = tuple(factor for factor in a_factors for _ in range(b))
            terms.add(factors)

    print(len(terms))


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


def get_prime_factors(number, primes):
    """Get prime factors of a number"""

    factors = []
    for prime in primes:
        while number % prime == 0:
            factors.append(prime)
            number /= prime

    return factors

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Distinct powers')
    parser.add_argument(
        'max', metavar='MAX', type=int, default=100, nargs='?',
        help='The maximum value of a and b')
    args = parser.parse_args()

    main(args)
