#!/usr/bin/env python

"""This script solves the Project Euler problem "Power digit sum". The problem
is: What is the sum of the digits of the number 2^1000?
"""

import argparse


def main(args):
    """Power digit sum"""

    digits = [1]

    for _ in range(args.power):
        doubled_digits = []
        carry = 0
        for digit in digits:
            digit_sum = digit * 2 + carry
            doubled_digits.append(int(str(digit_sum)[-1]))
            if digit_sum >= 10:
                carry = int(str(digit_sum)[:-1])
            else:
                carry = 0
        doubled_digits.extend([int(i) for i in str(carry)])
        digits = doubled_digits

    print(sum(digits))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Power digit sum')
    parser.add_argument(
        'power', metavar='POWER', type=int, default=1000, nargs='?',
        help='The power to raise 2 to')
    args = parser.parse_args()

    main(args)
