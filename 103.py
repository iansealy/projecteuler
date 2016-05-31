#!/usr/bin/env python

"""This script solves the Project Euler problem "Special subset sums: optimum".
The problem is: Given that A is an optimum special sum set for n = 7, find its
set string.
"""

from __future__ import division
import argparse
from itertools import product, combinations, chain


def main(args):
    """Special subset sums: optimum"""

    full_set = set([1])
    for n in range(2, args.set_size + 1):
        full_set = algorithm_set(full_set)
        full_set = optimum_set(full_set)

    print(''.join(map(str, sorted(full_set))))


def algorithm_set(prev_set):
    """Get set from previous set using algorithm"""

    middle = sorted(prev_set)[len(prev_set) // 2]
    new_set = set([middle])
    for i in sorted(prev_set):
        new_set.add(middle + i)

    return new_set


def optimum_set(algo_set):
    """Get optimum set from algorithm set using nearby search"""

    n = len(algo_set)

    opt_sum = sum(algo_set)
    opt_set = algo_set
    for offset in product(range(-2, 3), repeat=n):
        test_set = set([i + j for i, j in zip(sorted(algo_set), offset)])

        if sum(test_set) > opt_sum:
            continue
        if len(test_set) != n:
            continue
        if any(i <= 0 for i in test_set):
            continue

        subsets = list(chain.from_iterable(combinations(test_set, i)
                                           for i in range(n + 1)))
        subsets = [set(sub) for sub in subsets]
        subsets = [sub for sub in subsets if len(sub) > 0 and len(sub) < n]

        sums = [sum(sub) for sub in subsets]
        lens = [len(sub) for sub in subsets]

        # Check for disjoint subsets with equal sums
        got_disjoint_eq_sum = False
        for subset_sum in set(sums):
            indices = [i for i, s in enumerate(sums) if s == subset_sum]
            if len(indices) == 1:
                continue
            for i, j in combinations(indices, 2):
                if not len(subsets[i].intersection(subsets[j])):
                    got_disjoint_eq_sum = True
                    break
        if got_disjoint_eq_sum:
            continue

        # Check for disjoint subsets of different lengths and sums
        got_disjoint_diff = False
        for i, j in combinations(range(len(subsets)), 2):
            if lens[i] == lens[j] or sums[i] == sums[j]:
                continue
            if len(subsets[i].intersection(subsets[j])):
                continue
            if lens[i] > lens[j] and sums[i] < sums[j]:
                got_disjoint_diff = True
                break
            if lens[j] > lens[i] and sums[j] < sums[i]:
                got_disjoint_diff = True
                break
        if got_disjoint_diff:
            continue

        opt_sum = sum(test_set)
        opt_set = test_set

    return opt_set

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Special subset sums: optimum')
    parser.add_argument(
        'set_size', metavar='SET_SIZE', type=int, default=7, nargs='?',
        help='The set size')
    args = parser.parse_args()

    main(args)
