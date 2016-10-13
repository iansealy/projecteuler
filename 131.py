#!/usr/bin/env python

"""This script solves the Project Euler problem "Prime cube partnership". The
problem is: How many primes below one million have this remarkable property?
"""

import argparse
import math


def main(args):
    """Prime cube partnership"""

    count = 0

    n = 1
    while True:
        n += 1
        diff = n * n * n - (n - 1) * (n - 1) * (n - 1)
        if diff > args.limit:
            break
        if is_prime(diff):
            count += 1

    print(count)


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
    parser = argparse.ArgumentParser(
        description='Prime cube partnership')
    parser.add_argument(
        'limit', metavar='limit', type=int, default=1000000, nargs='?',
        help='The maximum prime')
    args = parser.parse_args()

    main(args)
