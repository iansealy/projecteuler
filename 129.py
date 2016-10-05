#!/usr/bin/env python

"""This script solves the Project Euler problem "Repunit divisibility". The
problem is: Find the least value of n for which A(n) first exceeds one-million.
"""

import argparse


def main(args):
    """Repunit divisibility"""

    n = args.minimum
    while True:
        n += 1
        if n % 2 == 0 or n % 5 == 0:
            continue
        rkmodn = 1
        k = 1
        while rkmodn % n != 0:
            k += 1
            rkmodn = (rkmodn * 10 + 1) % n
        if k > args.minimum:
            break

    print(n)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Repunit divisibility')
    parser.add_argument(
        'minimum', metavar='MINIMUM', type=int, default=1000000, nargs='?',
        help='The minimum value of A(n)')
    args = parser.parse_args()

    main(args)
