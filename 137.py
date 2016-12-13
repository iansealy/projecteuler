#!/usr/bin/env python

"""This script solves the Project Euler problem "Fibonacci golden nuggets".
The problem is: Find the 15th golden nugget.
"""

import argparse
import math


def main(args):
    """Fibonacci golden nuggets"""

    print(fib(2 * args.ordinal) * fib(2 * args.ordinal + 1))


def fib(n):
    """Calculate Fibonacci number"""

    return int((pow(1 + math.sqrt(5), n) - pow(1 - math.sqrt(5), n)) /
               (pow(2, n) * math.sqrt(5)))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Fibonacci golden nuggets')
    parser.add_argument(
        'ordinal', metavar='ORDINAL', type=int, default=15, nargs='?',
        help='The required ordinal golden nugget')
    args = parser.parse_args()

    main(args)
