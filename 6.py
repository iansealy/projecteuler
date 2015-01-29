#!/usr/bin/env python

"""This script solves the Project Euler problem "Sum square difference". The
problem is: Find the difference between the sum of the squares of the first one
hundred natural numbers and the square of the sum.
"""

import argparse


def main(args):
    """Sum square difference"""

    sum_squares = 0
    sum_sequence = 0
    for num in range(1, args.max_num + 1):
        sum_squares += num * num
        sum_sequence += num
    square_sum = sum_sequence * sum_sequence
    diff = square_sum - sum_squares

    print(diff)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Sum square difference')
    parser.add_argument(
        'max_num', metavar='MAXNUM', type=int, default=100, nargs='?',
        help='The number ending the sequence to find the difference of')
    args = parser.parse_args()

    main(args)
