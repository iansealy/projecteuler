#!/usr/bin/env python

"""This script solves the Project Euler problem "Singleton difference". The
problem is: How many values of n less than fifty million have exactly one
solution?
"""

from __future__ import division
import argparse
import sys
from collections import defaultdict

if sys.version_info[0] < 3:
    range = xrange


def main(args):
    """Singleton difference"""

    # x = y + d
    # z = y - d
    # x^2 - y^2 - z^2 = n
    # (y + d)^2 -y^2 - (y - d)^2 = n
    # 4dy - y^2 = n
    # y(4d - y) = n
    count = defaultdict(int)
    for y in range(1, args.limit + 1):
        for d in range(y // 4 + 1, args.limit + 1):
            if y - d < 1:
                break
            n = y * (4 * d - y)
            if n > args.limit:
                break
            count[n] += 1

    print(len([i for i in count if count[i] == 1]))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Singleton difference')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=50000000, nargs='?',
        help='The maximum value of n')
    args = parser.parse_args()

    main(args)
