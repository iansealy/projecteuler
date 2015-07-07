#!/usr/bin/env python

"""This script solves the Project Euler problem "Prime digit replacements".
Find the smallest prime which, by replacing part of the number (not necessarily
adjacent digits) with the same digit, is part of an eight prime value family.
"""

from __future__ import division
import argparse
import math
import itertools


def main(args):
    """Prime digit replacements"""

    digits = 1
    smallest_prime = None
    while smallest_prime is None:
        digits += 1
        smallest_prime = get_smallest_prime(digits, args.prime_value)

    print(smallest_prime)


def get_smallest_prime(digits, prime_value):
    """Get smallest prime in family"""

    limit = pow(10, digits) - 1

    primes = [i for i in get_primes_up_to(limit) if len(str(i)) == digits]
    is_prime = {prime: True for prime in primes}

    for n in range(1, digits):
        for combination in itertools.combinations(range(digits), n):
            prime_count = {}
            for prime in primes:
                prime_base = str(prime)
                removed = {}
                for pos in combination:
                    removed[prime_base[pos:pos+1]] = True
                    prime_base = prime_base[:pos] + 'x' + prime_base[pos+1:]
                if len(removed) == 1:
                    if prime_base not in prime_count:
                        prime_count[prime_base] = 0
                    prime_count[prime_base] += 1
            try:
                prime_bases = [p for p in prime_count.iterkeys()
                               if prime_count[p] == prime_value]
            except AttributeError:
                prime_bases = [p for p in prime_count.keys()
                               if prime_count[p] == prime_value]
            for prime_base in prime_bases:
                for replace in range(10):
                    prime = prime_base.replace('x', str(replace))
                    if int(prime) in is_prime:
                        return(prime)

    return(None)


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
    parser = argparse.ArgumentParser(description='Prime digit replacements')
    parser.add_argument(
        'prime_value', metavar='PRIME_VALUE', type=int, default=8, nargs='?',
        help='The value of the prime family')
    args = parser.parse_args()

    main(args)
