#!/usr/bin/env python

"""This script solves the Project Euler problem "Digit cancelling fractions".
The problem is: If the product of these four fractions is given in its lowest
common terms, find the value of the denominator.
"""

from __future__ import division
import math


def main():
    """Digit cancelling fractions"""

    num_product = 1
    denom_product = 1

    for num in range(10, 99):
        num1 = int(str(num)[0:1])
        num2 = int(str(num)[1:2])
        for denom in range(num + 1, 100):
            denom1 = int(str(denom)[0:1])
            denom2 = int(str(denom)[1:2])
            if denom2 == 0:
                continue
            if ((num1 == denom2 and num2 / denom1 == num / denom)
                    or (num2 == denom1 and num1 / denom2 == num / denom)):
                num_product *= num
                denom_product *= denom

    primes = get_primes_up_to(num_product)
    for prime in primes:
        while num_product % prime == 0 and denom_product % prime == 0:
            num_product //= prime
            denom_product //= prime

    print(denom_product)


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
