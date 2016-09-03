#!/usr/bin/env python

"""This script solves the Project Euler problem "Efficient exponentiation". The
problem is: For 1 <= k <= 200, find sum m(k).
"""

import argparse


def main(args):
    """Efficient exponentiation"""

    multiplications = make_tree(1, 0, [], [float('inf')] * (args.limit + 1),
                                args.limit)

    print(sum(multiplications[1:]))


def make_tree(exponent, depth, tree, multiplications, limit):
    if exponent > limit or depth > multiplications[exponent]:
        return(multiplications)

    multiplications[exponent] = depth
    try:
        tree[depth] = exponent
    except IndexError:
        tree.append(exponent)

    for prev_depth in range(depth, -1, -1):
        multiplications = make_tree(exponent + tree[prev_depth], depth + 1,
                                    tree, multiplications, limit)

    return(multiplications)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Efficient exponentiation')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=200, nargs='?',
        help='The maximum value of k')
    args = parser.parse_args()

    main(args)
