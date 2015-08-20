#!/usr/bin/env python

"""This script solves the Project Euler problem "Odd period square roots". The
problem is: How many continued fractions for N <= 10000 have an odd period?
"""

from __future__ import division
import argparse
import math


def main(args):
    """Odd period square roots"""

    odd_count = 0
    for n in range(2, args.limit + 1):
        if math.sqrt(n) == math.floor(math.sqrt(n)):
            continue

        m = [0]
        d = [1]
        a = [math.floor(math.sqrt(n))]

        while a[-1] != 2 * a[0]:
            m.append(d[-1] * a[-1] - m[-1])
            d.append((n - m[-1] * m[-1]) // d[-1])
            a.append((a[0] + m[-1]) // d[-1])
        if len(a) % 2 == 0:
            odd_count += 1

    print(odd_count)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Odd period square roots')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=10000, nargs='?',
        help='The limit on N, the number whose square root is to be taken')
    args = parser.parse_args()

    main(args)
