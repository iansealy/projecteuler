#!/usr/bin/env python

"""This script solves the Project Euler problem "Prime summations". The problem
is: What is the first value which can be written as the sum of primes in over
five thousand different ways?
"""

from __future__ import division
import argparse
import math
import re


def main(args):
    """Prime summations"""

    n = 0
    num_ways = 0
    primes = []
    while num_ways < args.minimum:
        n += 1
        if re.match(r'^10*$', str(n)):
            primes = get_primes_up_to(n * 10)
        num_ways = ways(n, [prime for prime in primes if prime < n])

    print(n)


def ways(total, numbers):
    """Recursively calculate number of ways to make sums"""

    if total < 0:
        return 0
    if total == 0:
        return 1

    count = 0
    while(numbers):
        count += ways(total - numbers[0], numbers)
        numbers = numbers[1:]

    return count


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
    parser = argparse.ArgumentParser(description='Prime summations')
    parser.add_argument(
        'minimum', metavar='MINIMUM', type=int, default=5001, nargs='?',
        help='The minimum number of prime sums')
    args = parser.parse_args()

    main(args)
