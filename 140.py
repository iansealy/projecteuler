#!/usr/bin/env python

"""This script solves the Project Euler problem "Modified Fibonacci golden
nuggets". The problem is: Find the sum of the first thirty golden nuggets.
"""

import argparse
import math


def main(args):
    """Modified Fibonacci golden nuggets"""

    nuggets = []
    n = 0
    up_or_down = 1
    while len(nuggets) < args.ordinal:
        n += up_or_down
        discriminant = math.sqrt(5 * n * n + 14 * n + 1)
        if math.floor(discriminant) == discriminant:
            nuggets.append(n)
            if len(nuggets) > 2:
                up_or_down = -1
                n = int(nuggets[-2] * nuggets[-1] / nuggets[-3])

    print(sum(nuggets))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Modified Fibonacci golden nuggets')
    parser.add_argument(
        'ordinal', metavar='ORDINAL', type=int, default=30, nargs='?',
        help='The ordinal of the last golden nugget')
    args = parser.parse_args()

    main(args)
