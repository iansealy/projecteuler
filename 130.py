#!/usr/bin/env python

"""This script solves the Project Euler problem "Composites with prime repunit
property". The problem is: Find the sum of the first twenty-five composite
values of n for which GCD(n, 10) = 1 and n - 1 is divisible by A(n).
"""

import argparse
import math


def main(args):
    """Composites with prime repunit property"""

    composite = []
    n = 90
    while len(composite) < args.limit:
        n += 1
        if n % 2 == 0 or n % 5 == 0 or is_prime(n):
            continue
        rkmodn = 1
        k = 1
        while rkmodn % n != 0:
            k += 1
            rkmodn = (rkmodn * 10 + 1) % n
        if (n - 1) % k != 0:
            continue
        composite.append(n)

    print(sum(composite))


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
        description='Composites with prime repunit property')
    parser.add_argument(
        'limit', metavar='limit', type=int, default=25, nargs='?',
        help='The number of composite values to sum')
    args = parser.parse_args()

    main(args)
