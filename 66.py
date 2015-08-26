#!/usr/bin/env python

"""This script solves the Project Euler problem "Diophantine equation". The
problem is: Find the value of D <= 1000 in minimal solutions of x for which the
largest value of x is obtained.
"""

from __future__ import division
import argparse
import math


def main(args):
    """Diophantine equation"""

    n_with_largest_x = None
    largest_x = 0

    for n in range(2, args.limit + 1):
        if math.sqrt(n) == math.floor(math.sqrt(n)):
            continue

        m = [0]
        d = [1]
        a = [int(math.floor(math.sqrt(n)))]

        x_prev2 = 1
        x_prev1 = a[0]
        y_prev2 = 0
        y_prev1 = 1

        while True:
            m.append(d[-1] * a[-1] - m[-1])
            d.append((n - m[-1] * m[-1]) // d[-1])
            a.append((a[0] + m[-1]) // d[-1])

            x = a[-1] * x_prev1 + x_prev2
            y = a[-1] * y_prev1 + y_prev2

            if x * x - n * y * y == 1:
                if x > largest_x:
                    n_with_largest_x = n
                    largest_x = x
                break

            x_prev2 = x_prev1
            x_prev1 = x
            y_prev2 = y_prev1
            y_prev1 = y

    print(n_with_largest_x)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Diophantine equation')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=1000, nargs='?',
        help='The limit on D')
    args = parser.parse_args()

    main(args)
