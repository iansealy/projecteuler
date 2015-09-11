#!/usr/bin/env python

"""This script solves the Project Euler problem "Totient permutation". The
problem is: Find the value of n, 1 < n < 10^7, for which phi(n) is a
permutation of n and the ratio n/phi(n) produces a minimum.
"""

from __future__ import division
import math


def main():
    """Totient permutation"""

    # Constants
    LIMIT = 1e7

    min_ratio = None
    n_for_min_ratio = None

    primes = get_primes_up_to(int(2 * math.sqrt(LIMIT)))

    for i in primes:
        for j in primes:
            if j < i:
                continue
            n = i * j
            if n >= LIMIT:
                continue
            phi = n * (1 - 1 / i)
            if i != j:
                phi *= (1 - 1 / j)
            if not is_perm(n, int(phi)):
                continue
            ratio = n / phi
            if min_ratio is None or ratio < min_ratio:
                min_ratio = ratio
                n_for_min_ratio = n

    print(n_for_min_ratio)


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


def is_perm(num1, num2):
    """Check if two numbers are permutations of each other"""

    return(sorted(str(num1)) == sorted(str(num2)))

if __name__ == '__main__':
    main()
