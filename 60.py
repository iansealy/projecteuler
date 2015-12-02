#!/usr/bin/env python

"""This script solves the Project Euler problem "Prime pair sets". The problem
is: Find the lowest sum for a set of five primes for which any two primes
concatenate to produce another prime.
"""

from __future__ import division
import argparse
import math
from collections import defaultdict


def main(args):
    """Prime pair sets"""

    limit = 10
    min_set_sum = limit * limit

    while min_set_sum == limit * limit:
        limit *= 10
        min_set_sum = limit * limit

        primes = get_primes_up_to(limit)

        pair = defaultdict(set)
        for prime1 in primes:
            for prime2 in primes:
                if prime2 <= prime1:
                    continue
                concat1 = int(str(prime1) + str(prime2))
                concat2 = int(str(prime2) + str(prime1))
                if is_prime(concat1) and is_prime(concat2):
                    pair[prime1].add(prime2)

        try:
            primes = sorted(pair.iterkeys())
        except AttributeError:
            primes = sorted(pair.keys())
        for prime in primes:
            if prime > min_set_sum:
                break
            min_set_sum = get_set(pair, pair[prime], [prime], args.set_size,
                                  min_set_sum)

    print(min_set_sum)


def get_set(pair, candidates, prime_set, set_size, min_set_sum):
    """Get minimum sum of intersecting sets"""

    set_sum = sum(prime_set)

    if len(prime_set) == set_size:
        if set_sum < min_set_sum:
            return(set_sum)
        else:
            return(min_set_sum)

    for prime in sorted(candidates):
        if set_sum + prime > min_set_sum:
            return(min_set_sum)
        intersect = candidates & pair[prime]
        new_prime_set = list(prime_set)
        new_prime_set.append(prime)
        min_set_sum = get_set(pair, intersect, new_prime_set, set_size,
                              min_set_sum)

    return(min_set_sum)


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


def is_prime(num):
    """Test if number is prime"""

    if num == 1:      # 1 isn't prime
        return False
    if num < 4:       # 2 and 3 are prime
        return True
    if num % 2 == 0:  # Even numbers aren't prime
        return False
    if num < 9:       # 5 and 7 are prime
        return True
    if num % 3 == 0:  # Numbers divisible by 3 aren't prime
        return False

    num_sqrt = int(math.sqrt(num))
    factor = 5
    while factor <= num_sqrt:
        if num % factor == 0:        # Primes greater than three are 6k-1
            return False
        if num % (factor + 2) == 0:  # Or 6k+1
            return False
        factor += 6
    return True

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Prime pair sets')
    parser.add_argument(
        'set_size', metavar='SET_SIZE', type=int, default=5, nargs='?',
        help='The target number of primes in the set')
    args = parser.parse_args()

    main(args)
