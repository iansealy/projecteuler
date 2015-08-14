#!/usr/bin/env python

"""This script solves the Project Euler problem "Cubic permutations". The
problem is: Find the smallest cube for which exactly five permutations of its
digits are cube.
"""

import argparse
from collections import defaultdict


def main(args):
    """Cubic permutations"""

    current_digits = 1
    num = 0
    cubes_for = defaultdict(list)
    lowest_cube = None
    while lowest_cube is None:
        num += 1
        cube = pow(num, 3)

        if current_digits < len(str(cube)):
            # Check if finished
            for cubes in cubes_for.values():
                if len(cubes) == args.perms:
                    low_cube = sorted(cubes)[0]
                    if lowest_cube is None or low_cube < lowest_cube:
                        lowest_cube = low_cube

            # Reset for another digit range
            current_digits = len(str(cube))
            cubes_for = defaultdict(list)

        key = ''.join(sorted([i for i in str(cube)]))
        cubes_for[key].append(cube)

    print(lowest_cube)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Cubic permutations')
    parser.add_argument(
        'perms', metavar='PERMS', type=int, default=5, nargs='?',
        help='The target number of digit permutations')
    args = parser.parse_args()

    main(args)
