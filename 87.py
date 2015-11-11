#!/usr/bin/env python

"""This script solves the Project Euler problem "Prime power triples". The
problem is: How many numbers below fifty million can be expressed as the sum of
a prime square, prime cube, and prime fourth power?
"""

from __future__ import division
import argparse
import math


def main(args):
    """Prime power triples"""

    primes = get_primes_up_to(int(math.sqrt(args.limit)))

    squares = []
    cubes = []
    fourths = []
    for prime in primes:
        square = prime * prime
        if square < args.limit:
            squares.append(square)
        cube = square * prime
        if cube < args.limit:
            cubes.append(cube)
        fourth = cube * prime
        if fourth < args.limit:
            fourths.append(fourth)

    expressible = set()
    for fourth in fourths:
        for cube in cubes:
            for square in squares:
                sum = square + cube + fourth
                if sum >= args.limit:
                    break
                expressible.add(sum)

    print(len(expressible))


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
    parser = argparse.ArgumentParser(description='Prime power triples')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=50000000, nargs='?',
        help='The maximum sum')
    args = parser.parse_args()

    main(args)
