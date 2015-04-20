#!/usr/bin/env python

"""This script solves the Project Euler problem "Quadratic primes". The problem
is: Find the product of the coefficients, a and b, for the quadratic expression
that produces the maximum number of primes for consecutive values of n,
starting with n = 0.
"""

from __future__ import division
import math


def main():
    """Quadratic primes"""

    # Constants
    MAX_A = 999
    MAX_B = 999
    PRIMES_LIMIT = 1000000

    is_prime = {prime: True for prime in get_primes_up_to(PRIMES_LIMIT)}

    max_n = 0
    max_product = 0

    for a in range(-MAX_A, MAX_A + 1):
        for b in range(-MAX_B, MAX_B + 1):
            n = 0
            while True:
                quadratic = n * n + a * n + b
                if quadratic not in is_prime:
                    break
                n += 1
            if n > max_n:
                max_n = n
                max_product = a * b

    print(max_product)


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
