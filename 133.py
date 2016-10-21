#!/usr/bin/env python

"""This script solves the Project Euler problem "Repunit nonfactors". The
problem is: Find the sum of all the primes below one-hundred thousand that will
never be a factor of R(10^n).
"""

import argparse
import math


def main(args):
    """Repunit nonfactors"""

    primes = set(get_primes_up_to(args.limit))
    for n in range(1, 17):
        for prime in primes.copy():
            if modular_exponentiation(10, 10**n, 9 * prime) == 1:
                primes.remove(prime)

    print(sum(primes))


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
    parser = argparse.ArgumentParser(
        description='Repunit nonfactors')
    parser.add_argument(
        'limit', metavar='limit', type=int, default=100000, nargs='?',
        help='The maximum prime')
    args = parser.parse_args()

    main(args)
