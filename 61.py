#!/usr/bin/env python

"""This script solves the Project Euler problem "Cyclical figurate numbers".
The problem is: Find the sum of the only ordered set of six cyclic 4-digit
numbers for which each polygonal type: triangle, square, pentagonal, hexagonal,
heptagonal, and octagonal, is represented by a different number in the set.
"""

from __future__ import division
import argparse
from collections import defaultdict


def main(args):
    """Cyclical figurate numbers"""

    functions = [
        lambda n: n * (n + 1) // 2,
        lambda n: n * n,
        lambda n: n * (3 * n - 1) // 2,
        lambda n: n * (2 * n - 1),
        lambda n: n * (5 * n - 3) // 2,
        lambda n: n * (3 * n - 2)
    ]

    polygonal = set()
    polygonal_type = defaultdict(set)
    prefix = defaultdict(set)
    for type in range(args.set_size):
        n = 1
        p = 1
        while p < 10000:
            p = functions[type](n)
            if p >= 1000 and p < 10000:
                polygonal.add(p)
                polygonal_type[p].add(type)
                prefix[str(p)[0:2]].add(p)
            n += 1

    set_sum = None
    for num in polygonal:
        set_sum = get_cycle([num], prefix, polygonal_type, args.set_size)
        if set_sum is not None:
            break

    print(set_sum)


def get_cycle(cycle, prefix, polygonal_type, set_size):
    """Recursively get possible cycles"""

    set_sum = None

    if len(cycle) == set_size:
        if str(cycle[0])[0:2] != str(cycle[-1])[2:4]:
            return(None)
        if all_represented(cycle, polygonal_type, set_size):
            return(sum(cycle))
        else:
            return(None)

    suffix = str(cycle[-1])[2:4]
    for next_num in prefix[suffix]:
        if next_num in cycle:
            continue
        new_cycle = list(cycle)
        new_cycle.append(next_num)
        set_sum = get_cycle(new_cycle, prefix, polygonal_type, set_size)
        if set_sum is not None:
            break

    return(set_sum)


def all_represented(cycle, polygonal_type, set_size):
    """Check if polygonal types are represented in cycle"""

    paths = [[]]

    for num in cycle:
        types = polygonal_type[num]
        if not len(types):
            return(False)
        new_paths = []
        for type in types:
            for path in paths:
                new_path = list(path)
                new_path.append(type)
                new_paths.append(new_path)
        paths = list(new_paths)

    for path in paths:
        if len(set(path)) == set_size:
            return(True)

    return(False)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Cyclical figurate numbers')
    parser.add_argument(
        'set_size', metavar='SET_SIZE', type=int, default=6, nargs='?',
        help='The number of 4-digit integers in the cyclic set')
    args = parser.parse_args()

    main(args)
