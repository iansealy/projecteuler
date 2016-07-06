#!/usr/bin/env python

"""This script solves the Project Euler problem "Diophantine reciprocals II".
The problem is: What is the least value of n for which the number of distinct
solutions exceeds four million?
"""

from __future__ import division
import argparse
import math
from itertools import combinations_with_replacement


def main(args):
    """Diophantine reciprocals II"""

    primes = get_primes_up_to(args.limit)

    max_primes = int(math.ceil(math.log(2 * args.limit, 3)))
    primes = primes[0:max_primes]

    exponent_set = [1]
    min_n2 = None
    prev_min_n2 = None
    while prev_min_n2 is None or min_n2 != prev_min_n2:
        prev_min_n2 = min_n2
        exponent_set.append(exponent_set[-1] + 2)
        for comb in combinations_with_replacement(exponent_set, max_primes):
            product = 1
            for n in comb:
                product *= n
            if product > args.limit * 2:
                exponents = list(reversed(comb))
                n2 = 1
                for i in range(max_primes):
                    n2 *= pow(primes[i], exponents[i] - 1)
                if min_n2 is not None and n2 >= min_n2:
                    continue
                min_n2 = n2

    print(int(math.sqrt(min_n2)))


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
    parser = argparse.ArgumentParser(description='Diophantine reciprocals II')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=4000000, nargs='?',
        help='The minimum number of distinct solutions')
    args = parser.parse_args()

    main(args)
