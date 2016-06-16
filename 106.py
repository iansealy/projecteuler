#!/usr/bin/env python

"""This script solves the Project Euler problem "Special subset sums:
meta-testing". The problem is: For n = 12, how many of the 261625 subset pairs
that can be obtained need to be tested for equality?
"""

from __future__ import division
import argparse
from itertools import combinations, chain


def main(args):
    """Special subset sums: meta-testing"""

    n = args.set_size

    full_set = set(range(1, n + 1))

    subsets = list(chain.from_iterable(combinations(full_set, i)
                                       for i in range(n + 1)))
    subsets = [set(sub) for sub in subsets]
    subsets = [sub for sub in subsets if len(sub) > 0 and len(sub) < n]

    count = 0
    for i in range(len(subsets) - 1):
        subset1 = subsets[i]
        for j in range(i + 1, len(subsets)):
            subset2 = subsets[j]
            if len(subset1) != len(subset2):
                continue
            if len(subset1) == 1 and len(subset2) == 1:
                continue
            if len(subset1.intersection(subset2)):
                continue
            diff = [x - y for x, y in zip(sorted(subset1), sorted(subset2))]
            if all(x > 0 for x in diff) or all(x < 0 for x in diff):
                continue
            count += 1

    print(count)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Special subset sums: meta-testing')
    parser.add_argument(
        'set_size', metavar='SET_SIZE', type=int, default=12, nargs='?',
        help='The set size')
    args = parser.parse_args()

    main(args)
