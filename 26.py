#!/usr/bin/env python

"""This script solves the Project Euler problem "Reciprocal cycles". The
problem is: Find the value of d < 1000 for which 1/d contains the longest
recurring cycle in its decimal fraction part.
"""

from __future__ import division
import argparse


def main(args):
    """Reciprocal cycles"""

    max_denominator = 0
    max_cycle = 0
    for denominator in range(2, args.denominators + 1):
        remainder = 1 % denominator
        first_seen = {}
        digit = 0
        while remainder:
            digit += 1
            remainder *= 10
            whole = remainder // denominator
            remainder = remainder % denominator
            key = str(whole) + ':' + str(remainder)
            if key in first_seen:
                # Got cycle
                cycle = digit - first_seen[key]
                if cycle > max_cycle:
                    max_cycle = cycle
                    max_denominator = denominator
                remainder = 0
            else:
                first_seen[key] = digit

    print(max_denominator)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Reciprocal cycles')
    parser.add_argument(
        'denominators', metavar='DENOMINATORS', type=int, default=999,
        nargs='?', help='The maximum denominator')
    args = parser.parse_args()

    main(args)
