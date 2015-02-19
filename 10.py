#!/usr/bin/env python

"""This script solves the Project Euler problem "Summation of primes". The
problem is: Find the sum of all the primes below two million.
"""

import argparse
import math


def main(args):
    """Summation of primes"""

    candidate = 3
    sum = 2  # 2 is a prime

    while candidate < args.limit:
        if is_prime(candidate):
            sum += candidate
        candidate += 2

    print(sum)


def is_prime(num):
    """Test if number is prime"""

    if num == 1:      # 1 isn't prime
        return False
    if num < 4:       # 2 and 3 are prime
        return True
    if num % 2 == 0:  # Odd numbers aren't prime
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
    parser = argparse.ArgumentParser(description='Summation of primes')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=2000000, nargs='?',
        help='The number below which to sum up all primes')
    args = parser.parse_args()

    main(args)
