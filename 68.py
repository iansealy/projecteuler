#!/usr/bin/env python

"""This script solves the Project Euler problem "Magic 5-gon ring". The problem
is: Using the numbers 1 to 10, and depending on arrangements, it is possible to
form 16- and 17-digit strings. What is the maximum 16-digit string for a
"magic" 5-gon ring?
"""

import argparse
from collections import defaultdict
from itertools import combinations, permutations
from copy import deepcopy


def main(args):
    """Magic 5-gon ring"""

    # Group combinations by total
    comb_by_total = defaultdict(list)
    for comb in combinations(range(1, args.max_digit + 1), 3):
        comb_by_total[sum(comb)].append(list(comb))

    # Group combinations into rings with correct digits
    combs = []
    try:
        totals = comb_by_total.iterkeys()
    except AttributeError:
        totals = comb_by_total.keys()
    for total in totals:
        if len(comb_by_total[total]) < args.ring_size:
            continue
        for comb in combinations(comb_by_total[total], args.ring_size):
            digit_seen = defaultdict(int)
            for group in comb:
                for digit in group:
                    digit_seen[digit] += 1
            if len(digit_seen) != args.max_digit:
                continue
            if max(digit_seen.values()) != 2:
                continue
            # Reorder so first digit is the one that only appears once
            for group in comb:
                group.sort(key=lambda digit: digit_seen[digit])
            combs.append(comb)

    # Make all combinations of last two digits of each group
    new_combs = []
    for comb in combs:
        group1 = comb[0]
        group2 = [group1[0], group1[2], group1[1]]
        digit_combs = [[group1], [group2]]
        for i in range(1, args.ring_size):
            group1 = comb[i]
            group2 = [group1[0], group1[2], group1[1]]
            new_digit_combs = []
            for digit_perm in digit_combs:
                digit_perm1 = deepcopy(digit_perm)
                digit_perm2 = deepcopy(digit_perm)
                digit_perm1.append(group1)
                digit_perm2.append(group2)
                new_digit_combs.append(digit_perm1)
                new_digit_combs.append(digit_perm2)
            digit_combs = new_digit_combs
        new_combs.extend(digit_combs)
    combs = new_combs

    # Get all permutations of each combination and filter invalid ones
    max_string = '0' * args.target_digits
    for comb in combs:
        for perm in permutations(comb):
            if perm[0][0] != min(group[0] for group in perm):
                continue
            string = ''
            for i in range(0, args.ring_size):
                if perm[i][2] != perm[(i + 1) % args.ring_size][1]:
                    break
                string += ''.join(str(digit) for digit in perm[i])
            if len(string) != args.target_digits:
                continue
            if string > max_string:
                max_string = string

    print(max_string)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Magic 5-gon ring')
    parser.add_argument(
        'ring_size', metavar='RING_SIZE', type=int, default=5, nargs='?',
        help='The number of vertices in the magic ring')
    parser.add_argument(
        'max_digit', metavar='MAX_DIGIT', type=int, default=10, nargs='?',
        help='The number of digits to fill the rings with')
    parser.add_argument(
        'target_digits', metavar='TARGET_DIGITS', type=int, default=16,
        nargs='?', help='The number of digits in the solution')
    args = parser.parse_args()

    main(args)
