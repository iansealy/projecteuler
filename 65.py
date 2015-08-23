#!/usr/bin/env python

"""This script solves the Project Euler problem "Convergents of e". The problem
is: Find the sum of digits in the numerator of the 100th convergent of the
continued fraction for e.
"""

from __future__ import division
import argparse


def main(args):
    """Convergents of e"""

    a = [2]
    for n in range(1, int((args.limit - 1) / 3) + 2):
        a.extend([1, 2 * n, 1])

    numer = [2, 3]
    for n in range(2, args.limit):
        numer.append(a[n] * numer[-1] + numer[-2])

    print(sum(int(i) for i in str(numer[-1])))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Convergents of e')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=100, nargs='?',
        help='The number of convergents')
    args = parser.parse_args()

    main(args)
