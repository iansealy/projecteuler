#!/usr/bin/env python

"""This script solves the Project Euler problem "Circular primes". The problem
is: How many circular primes are there below one million?
"""

from __future__ import division
import math
import argparse


def main(args):
    """Circular primes"""

    primes = get_primes_up_to(args.max - 1)
    is_prime = {prime: True for prime in primes}

    circular = []
    for prime in primes:
        is_circular = True
        for _ in range(len(str(prime))):
            prime = int(str(prime)[-1:] + str(prime)[:-1])
            if prime not in is_prime:
                is_circular = False
        if is_circular:
            circular.append(prime)

    print(len(circular))


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
    parser = argparse.ArgumentParser(description='Circular primes')
    parser.add_argument(
        'max', metavar='MAX', type=int, default=1000000, nargs='?',
        help='The maximum to check for circular primes')
    args = parser.parse_args()

    main(args)
