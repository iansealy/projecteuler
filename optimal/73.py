#!/usr/bin/env python

"""This script solves the Project Euler problem "Counting fractions in a
range". The problem is: How many fractions lie between 1/3 and 1/2 in the
sorted set of reduced proper fractions for d <= 12,000?
"""

from __future__ import division
import argparse
import math
from collections import defaultdict


def main(args):
    """Counting fractions in a range"""

    k0 = int(math.floor(math.sqrt(args.limit / 2)))
    m0 = int(math.floor(args.limit / (2 * k0 + 1)))
    r_small = defaultdict(int)
    r_large = defaultdict(int)

    for n in range(5, m0 + 1):
        r(n, m0, r_small, r_large)
    for j in range(k0 - 1, -1, -1):
        r(args.limit // (2 * j + 1), m0, r_small, r_large)

    print(r_large[0])


def f(n):
    q = n // 6
    r = n % 6
    f = q * (3 * q - 2 + r)
    if r == 5:
        f += 1
    return(f)


def r(n, m0, r_small, r_large):
    switch = math.floor(math.sqrt(n / 2))
    count = f(n)
    count -= f(n // 2)
    m = 5
    k = (n - 5) // 10
    while k >= switch:
        next_k = (n // (m + 1) - 1) // 2
        count -= ((k - next_k) * r_small[m])
        k = next_k
        m += 1
    while k > 0:
        m = n // (2 * k + 1)
        if m <= m0:
            count -= r_small[m]
        else:
            count -= r_large[((args.limit // m) - 1) // 2]
        k -= 1
    if n <= m0:
        r_small[n] = count
    else:
        r_large[((args.limit // n) - 1) // 2] = count

    return()

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Counting fractions in a range')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=12000, nargs='?',
        help='The limit on d')
    args = parser.parse_args()

    main(args)
