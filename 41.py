#!/usr/bin/env python

"""This script solves the Project Euler problem "Pandigital prime". The problem
is: What is the largest n-digit pandigital prime that exists?
"""

from __future__ import division
import math


def main():
    """Pandigital prime"""

    max_pandigital = 0
    primes = get_primes_up_to(10000000)
    for prime in reversed(primes):
        if '0' in str(prime):
            continue
        num_digits = len(str(prime))
        digits = set(int(i) for i in str(prime))
        if len(digits) != num_digits:
            continue
        if max(digits) > num_digits:
            continue
        max_pandigital = prime
        break

    print(max_pandigital)


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
    main()
