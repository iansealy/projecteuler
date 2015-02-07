#!/usr/bin/env python

"""This script solves the Project Euler problem "10001st prime". The problem
is: What is the 10 001st prime number?
"""

import argparse
import math


def main(args):
    """10001st prime"""

    candidate = 1
    primes_got = 1  # 2 is a prime

    while primes_got < args.ordinal:
        candidate += 2
        if is_prime(candidate):
            primes_got += 1

    print(candidate)


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
    parser = argparse.ArgumentParser(description='10001st prime')
    parser.add_argument(
        'ordinal', metavar='ORDINAL', type=int, default=10001, nargs='?',
        help='The ordinal of the required prime')
    args = parser.parse_args()

    main(args)
