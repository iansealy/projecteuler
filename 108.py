#!/usr/bin/env python

"""This script solves the Project Euler problem "Diophantine reciprocals I".
The problem is: What is the least value of n for which the number of distinct
solutions exceeds one-thousand?
"""

from __future__ import division
import argparse
import math


def main(args):
    """Diophantine reciprocals I"""

    primes = get_primes_up_to(args.limit)

    n = 0
    solutions = 0
    while solutions <= args.limit:
        n += 1
        num_divisors = get_num_divisors(n * n, primes)
        solutions = (num_divisors + 1) // 2

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


def get_num_divisors(number, primes):
    """Get number of divisors of a number"""

    num_divisors = 1
    for prime in primes:
        if prime * prime > number:
            break
        exponent = 1
        while number % prime == 0:
            exponent += 1
            number /= prime
        num_divisors *= exponent

    return num_divisors

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Diophantine reciprocals I')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=1000, nargs='?',
        help='The minimum number of distinct solutions')
    args = parser.parse_args()

    main(args)
