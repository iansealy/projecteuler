#!/usr/bin/env python

"""This script solves the Project Euler problem "Highly divisible triangular
number". The problem is: What is the value of the first triangle number to
have over five hundred divisors?
"""

import argparse
import math


def main(args):
    """Largest prime factor"""

    ordinal = 1
    triangle_number = 1
    num_factors = 1

    while num_factors <= args.divisors:
        ordinal += 1
        triangle_number += ordinal
        num_factors = len(get_factors(triangle_number))

    print(triangle_number)


def get_factors(number):
    """Get all factors of a number"""

    factors = [1, number]

    for i in range(2, int(math.sqrt(number))):
        if number % i == 0:
            factors.extend([i, number / i])

    return(factors)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Highly divisible triangular number')
    parser.add_argument(
        'divisors', metavar='DIVISORS', type=int, default=500, nargs='?',
        help='The minimum number of divisors the triangle number should have')
    args = parser.parse_args()

    main(args)
