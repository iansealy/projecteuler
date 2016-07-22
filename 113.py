#!/usr/bin/env python

"""This script solves the Project Euler problem "Non-bouncy numbers". The
problem is: How many numbers below a googol (10^100) are not bouncy?
"""

import argparse
try:
    from functools import lru_cache
except ImportError:
    from functools32 import lru_cache


def main(args):
    """Non-bouncy numbers"""

    increasing = 0
    for num_digits in range(1, args.exponent + 1):
        for last_digit in range(1, 10):
            increasing += count_increasing(last_digit, num_digits)

    decreasing = 0
    for num_digits in range(1, args.exponent + 1):
        for last_digit in range(10):
            decreasing += count_decreasing(last_digit, num_digits)
        decreasing -= 1

    double_count = 9 * args.exponent

    print(increasing + decreasing - double_count)


@lru_cache()
def count_increasing(last_digit, length):
    if length == 1:
        return 1

    count = 0
    for prev_last_digit in range(1, last_digit + 1):
        count += count_increasing(prev_last_digit, length - 1)

    return count


@lru_cache()
def count_decreasing(last_digit, length):
    if length == 1:
        return 1

    count = 0
    for prev_last_digit in range(last_digit, 10):
        count += count_decreasing(prev_last_digit, length - 1)

    return count

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Non-bouncy numbers')
    parser.add_argument(
        'exponent', metavar='EXPONENT', type=int, default=100, nargs='?',
        help='Maximum value of n as an exponent of 10')
    args = parser.parse_args()

    main(args)
