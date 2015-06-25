#!/usr/bin/env python

"""This script solves the Project Euler problem "Distinct primes factors". The
problem is: Find the first four consecutive integers to have four distinct
prime factors. What is the first of these numbers?
"""

import argparse
import math


def main(args):
    """Distinct primes factors"""

    primes = get_primes_up_to(args.limit)

    n = 1
    consecutive = 0
    first = None
    while first is None and n < args.limit:
        n += 1
        if count_prime_factors(n, primes) == args.target:
            consecutive += 1
            if consecutive == args.target:
                first = n - args.target + 1
        else:
            consecutive = 0

    print(first)


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


def count_prime_factors(number, primes):
    """Count prime factors of a number"""

    factor = {}
    for prime in primes:
        if prime > number:
            break
        while number % prime == 0:
            factor[prime] = True
            number /= prime

    return len(factor)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Distinct primes factors')
    parser.add_argument(
        'target', metavar='TARGET', type=int, default=4, nargs='?',
        help='The target number of consecutive integers and prime factors')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=1000000, nargs='?',
        help='The maximum prime number')
    args = parser.parse_args()

    main(args)
