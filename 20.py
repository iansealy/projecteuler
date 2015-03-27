#!/usr/bin/env python

"""This script solves the Project Euler problem "Factorial digit sum". The
problem is: Find the sum of the digits in the number 100!
"""

import argparse


def main(args):
    """Factorial digit sum"""

    digits = [1]

    for number in range(2, args.factorial + 1):
        multiplied_digits = []
        carry = 0
        for digit in digits:
            digit_sum = digit * number + carry
            multiplied_digits.append(int(str(digit_sum)[-1]))
            if digit_sum >= 10:
                carry = int(str(digit_sum)[:-1])
            else:
                carry = 0
        multiplied_digits.extend([int(i) for i in str(carry)[::-1]])
        digits = multiplied_digits

    print(sum(digits))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Factorial digit sum')
    parser.add_argument(
        'factorial', metavar='FACTORIAL', type=int, default=100, nargs='?',
        help='The number to sum the factorial of')
    args = parser.parse_args()

    main(args)
