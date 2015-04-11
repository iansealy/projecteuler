#!/usr/bin/env python

"""This script solves the Project Euler problem "Lexicographic permutations".
The problem is: What is the millionth lexicographic permutation of the digits
0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?
"""

import argparse
import math


def main(args):
    """Lexicographic permutations"""

    permutation = []
    running_total = 0
    for perm_digits_left in reversed(range(1, args.digits + 1)):
        num_in_batch = math.factorial(perm_digits_left) / perm_digits_left
        for digit in range(args.digits):
            if digit in permutation:
                continue
            if running_total + num_in_batch >= args.ordinal:
                permutation.append(digit)
                break
            else:
                running_total += num_in_batch

    print(''.join(str(i) for i in permutation))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Lexicographic permutations')
    parser.add_argument(
        'digits', metavar='DIGITS', type=int, default=10, nargs='?',
        help='The number of digits to permute')
    parser.add_argument(
        'ordinal', metavar='ORDINAL', type=int, default=1000000, nargs='?',
        help='The permutation of interest')
    args = parser.parse_args()

    main(args)
