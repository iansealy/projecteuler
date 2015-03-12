#!/usr/bin/env python

"""This script solves the Project Euler problem "Lattice paths". The problem
is: How many such routes are there through a 20x20 grid?
"""

from __future__ import division
import argparse
import math


def main(args):
    """Lattice paths"""

    size = args.grid_size
    routes = math.factorial(size + size) / math.pow(math.factorial(size), 2)

    print(int(routes))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Lattice paths')
    parser.add_argument(
        'grid_size', metavar='GRID_SIZE', type=int, default=20, nargs='?',
        help='The size of the grid (INT x INT)')
    args = parser.parse_args()

    main(args)
