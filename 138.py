#!/usr/bin/env python

"""This script solves the Project Euler problem "Special isosceles triangles".
The problem is: Find sum L for the twelve smallest isosceles triangles for
which h = b +/- 1 and b, L are positive integers.
"""

import argparse
from mpmath import mp


def main(args):
    """Special isosceles triangles"""

    mp.dps = 100

    print(int(sum(fib(6 * n + 3) / 2 for n in range(1, args.ordinal + 1))))


def fib(n):
    """Calculate Fibonacci number"""

    return int((pow(1 + mp.sqrt(5), n) - pow(1 - mp.sqrt(5), n)) /
               (pow(2, n) * mp.sqrt(5)))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Special isosceles triangles')
    parser.add_argument(
        'ordinal', metavar='ORDINAL', type=int, default=12, nargs='?',
        help='The ordinal of the last required isosceles triangle')
    args = parser.parse_args()

    main(args)
