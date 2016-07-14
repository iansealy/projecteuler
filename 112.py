#!/usr/bin/env python

"""This script solves the Project Euler problem "Bouncy numbers". The problem
is: Find the least number for which the proportion of bouncy numbers is exactly
99%.
"""

from __future__ import division
import argparse


def main(args):
    """Primes with runs"""

    total = 100
    bouncy = 0
    while bouncy / total * 100 != args.proportion:
        total += 1
        if is_bouncy(total):
            bouncy += 1

    print(total)


def is_bouncy(num):
    """Test if number is bouncy"""

    digits = [int(i) for i in str(num)]
    seen_up = False
    seen_down = False
    for i in range(1, len(digits)):
        if digits[i] > digits[i - 1]:
            seen_up = True
        elif digits[i] < digits[i - 1]:
            seen_down = True
        if seen_up and seen_down:
            return True

    return False

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Bouncy numbers')
    parser.add_argument(
        'proportion', metavar='PROPORTION', type=int, default=99, nargs='?',
        help='Target proportion of bouncy numbers')
    args = parser.parse_args()

    main(args)
