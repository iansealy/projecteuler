#!/usr/bin/env python

"""This script solves the Project Euler problem "Highly divisible triangular
number". The problem is: What is the value of the first triangle number to
have over five hundred divisors?
"""

from __future__ import division
import argparse
import math


def main(args):
    """Highly divisible triangular number"""

    primes = get_primes_up_to(args.primes_limit)

    # Triangle numbers are of form n*(n+1)*2
    # D() = number of divisors
    # D(triangle number) = D(n/2)*D(n+1) if n is even
    #                   or D(n)*D((n+1)/2) if n+1 is even

    n = 3  # Start with a prime
    num_divisors_n = 2  # Always 2 for a prime
    num_factors = 0

    while num_factors <= args.divisors:
        n += 1
        n1 = n
        if n1 % 2 == 0:
            n1 //= 2
        num_divisors_n1 = 1

        for prime in primes:
            if prime * prime > n1:
                # Got last prime factor with exponent of 1
                num_divisors_n1 *= 2
                break

            exponent = 1
            while n1 % prime == 0:
                exponent += 1
                n1 //= prime
            if exponent > 1:
                num_divisors_n1 *= exponent
            if n1 == 1:
                break

        num_factors = num_divisors_n * num_divisors_n1
        num_divisors_n = num_divisors_n1

    print(n * (n - 1) // 2)


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
    parser = argparse.ArgumentParser(
        description='Highly divisible triangular number')
    parser.add_argument(
        'divisors', metavar='DIVISORS', type=int, default=500, nargs='?',
        help='The minimum number of divisors the triangle number should have')
    parser.add_argument(
        'primes_limit', metavar='PRIMES_LIMIT',
        type=int, default=1000, nargs='?',
        help='The highest number to check when generating a list of primes')
    args = parser.parse_args()

    main(args)
