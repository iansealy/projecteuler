#!/usr/bin/env python

"""This script solves the Project Euler problem "Special subset sums: testing".
The problem is: Using sets.txt, a 4K text file with one-hundred sets containing
seven to twelve elements, identify all the special sum sets, A1, A2, ..., Ak,
and find the value of S(A1) + S(A2) + ... + S(Ak).
"""

try:
    from urllib.request import urlopen
except ImportError:
    from urllib import urlopen
from itertools import combinations, chain


def main():
    """Special subset sums: testing"""

    # Constants
    SETS_URL = 'https://projecteuler.net/project/resources/p105_sets.txt'

    total = 0
    for line in urlopen(SETS_URL):
        candidate_set = set(int(i) for i in
                            line.rstrip().decode('ascii').split(','))
        if is_special_sum_set(candidate_set):
            total += sum(candidate_set)

    print(total)


def is_special_sum_set(candidate_set):
    """Check if set is special sum set"""

    n = len(candidate_set)

    subsets = list(chain.from_iterable(combinations(candidate_set, i)
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
        return False

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
        return False

    return True

if __name__ == '__main__':
    main()
