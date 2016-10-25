#!/usr/bin/env python

"""This script solves the Project Euler problem "Prime pair connection". The
problem is: Find sum S for every pair of consecutive primes with
5 <= p1 <= 1000000.
"""

import argparse
import math


def main(args):
    """Prime pair connection"""

    primes = get_primes_up_to(int(args.limit * 1.1))
    primes = [prime for prime in primes if prime >= 5]
    num_below_limit = len([prime for prime in primes if prime <= args.limit])
    primes = primes[0:num_below_limit + 1]

    total = 0

    for i in range(len(primes) - 1):
        prime1 = primes[i]
        prime2 = primes[i + 1]
        n = prime2
        multiplier = 2
        digits = len(str(prime1))
        while n % 10**digits != prime1:
            potential_multiplier = 10
            while n % potential_multiplier == prime1 % potential_multiplier:
                multiplier = potential_multiplier
                potential_multiplier *= 10
            n += prime2 * multiplier
        total += n

    print(total)


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
        description='Prime pair connection')
    parser.add_argument(
        'limit', metavar='limit', type=int, default=1000000, nargs='?',
        help='The maximum prime')
    args = parser.parse_args()

    main(args)
