#!/usr/bin/env python

"""This script solves the Project Euler problem "Right triangles with integer
coordinates". The problem is: Given that 0 <= x1, y1, x2, y2 <= 50, how many
right triangles can be formed?
"""

from __future__ import division
import argparse


def main(args):
    """Right triangles with integer coordinates"""

    count = 0
    for x1 in range(args.max + 1):
        for y1 in range(args.max + 1):
            if x1 == 0 and y1 == 0:
                continue
            op = [x1, y1]
            for x2 in range(args.max + 1):
                for y2 in range(args.max + 1):
                    if x2 == 0 and y2 == 0:
                        continue
                    if x1 == x2 and y1 == y2:
                        continue
                    oq = [x2, y2]
                    pq = [x2 - x1, y2 - y1]
                    if (not dot_product(op, oq) or
                            not dot_product(op, pq) or
                            not dot_product(oq, pq)):
                        count += 1

    print(count // 2)


def dot_product(v1, v2):
    return v1[0] * v2[0] + v1[1] * v2[1]

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Right triangles with integer coordinates')
    parser.add_argument(
        'max', metavar='MAX', type=int, default=50, nargs='?',
        help='The maximum x or y coordinate')
    args = parser.parse_args()

    main(args)
