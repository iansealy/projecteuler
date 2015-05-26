#!/usr/bin/env python

"""This script solves the Project Euler problem "Truncatable primes". The
problem is: Find the sum of the only eleven primes that are both truncatable
from left to right and right to left.
"""

from __future__ import division
import math


def main():
    """Truncatable primes"""

    # Constants
    TARGET_TRUNCATABLE = 11

    max_prime = 1
    truncatable = []

    while len(truncatable) < TARGET_TRUNCATABLE:
        max_prime *= 10
        truncatable = []

        primes = get_primes_up_to(max_prime)
        is_prime = {prime: True for prime in primes}
        for prime in primes:
            if is_truncatable(prime, is_prime):
                truncatable.append(prime)

    print(sum(truncatable))


def is_truncatable(prime, is_prime):
    """Check if prime is truncatable"""

    if prime < 10:
        return False

    for i in range(1, len(str(prime))):
        if int(str(prime)[i:]) not in is_prime:
            return False
        if int(str(prime)[0:i]) not in is_prime:
            return False

    return True


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
