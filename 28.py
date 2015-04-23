#!/usr/bin/env python

"""This script solves the Project Euler problem "Number spiral diagonals". The
problem is: What is the sum of the numbers on the diagonals in a 1001 by 1001
spiral formed in the same way?
"""

from __future__ import division
import argparse


def main(args):
    """Number spiral diagonals"""

    sum = 1  # Middle number
    current_width = 1
    increment = 0
    number = 1

    while current_width < args.width:
        current_width += 2
        increment += 2
        for _ in range(4):
            number += increment
            sum += number

    print(sum)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Number spiral diagonals')
    parser.add_argument(
        'width', metavar='WIDTH', type=int, default=1001, nargs='?',
        help='The width of the number spiral')
    args = parser.parse_args()

    main(args)
