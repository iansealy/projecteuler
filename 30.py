#!/usr/bin/env python

"""This script solves the Project Euler problem "Digit fifth powers". The
problem is: Find the sum of all the numbers that can be written as the sum of
fifth powers of their digits.
"""

import argparse


def main(args):
    """Digit fifth powers"""

    total_sum = 0

    # Work out maximum number of digits
    max_per_digit = pow(9, args.power)
    max_digits = 1
    while max_digits * max_per_digit > int('9' * max_digits):
        max_digits += 1

    number = 2
    max_number = pow(10, max_digits)
    while number < max_number:
        sum = 0
        for digit in str(number):
            sum += pow(int(digit), args.power)
        if sum == number:
            total_sum += number
        number += 1

    print(total_sum)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Digit fifth powers')
    parser.add_argument(
        'power', metavar='POWER', type=int, default=5, nargs='?',
        help='The power to raise digits by')
    args = parser.parse_args()

    main(args)
