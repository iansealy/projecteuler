#!/usr/bin/env python

"""This script solves the Project Euler problem "Totient maximum". The problem
is: Find the value of n <= 1,000,000 for which n/phi(n) is a maximum.
"""

import argparse
import math


def main(args):
    """Totient maximum"""

    n = 1
    prime = 1
    while True:
        prime += 1
        if not is_prime(prime):
            continue
        if n * prime > args.limit:
            break
        n *= prime

    print(n)


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
    parser = argparse.ArgumentParser(description='Totient maximum')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=1000000, nargs='?',
        help='The limit on n')
    args = parser.parse_args()

    main(args)
