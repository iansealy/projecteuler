#!/usr/bin/env python

"""This script solves the Project Euler problem "Goldbach's other conjecture".
The problem is: What is the smallest odd composite that cannot be written as
the sum of a prime and twice a square?
"""

from __future__ import division
import math


def main():
    """Goldbach's other conjecture"""

    limit = 100
    smallest = None
    while smallest is None:
        limit *= 10
        primes = get_primes_up_to(limit)
        is_prime = {i: True for i in primes}
        twice_squares = get_twice_squares_up_to(limit)
        is_twice_square = {i: True for i in twice_squares}
        n = 1
        while n < limit:
            n += 2
            if n in is_prime:
                continue
            is_prime_plus_twice_square = False
            for prime in primes:
                if prime >= n:
                    break
                if n - prime in is_twice_square:
                    is_prime_plus_twice_square = True
                    break
            if not is_prime_plus_twice_square:
                smallest = n
                break

    print(smallest)


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


def get_twice_squares_up_to(limit):
    """Get all twice squares up to specified limit"""

    twice_squares = [2]
    i = 1
    while twice_squares[-1] < limit:
        i += 1
        twice_squares.append(2 * i * i)

    return twice_squares

if __name__ == '__main__':
    main()
