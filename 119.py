#!/usr/bin/env python

"""This script solves the Project Euler problem "Digit power sum". The problem
is: What is the 10 001st prime number?
"""

import argparse


def main(args):
    """Digit power sum"""

    sequence = []
    digit_sum = 1
    while len(sequence) < 2 * args.ordinal:
        digit_sum += 1
        power = digit_sum
        while len(str(power)) < digit_sum:
            power *= digit_sum
            if power < 10:
                continue
            if sum([int(digit) for digit in str(power)]) == digit_sum:
                sequence.append(power)

    print(sorted(sequence)[args.ordinal - 1])

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Digit power sum')
    parser.add_argument(
        'ordinal', metavar='ORDINAL', type=int, default=30, nargs='?',
        help='The required ordinal of the sequence')
    args = parser.parse_args()

    main(args)
