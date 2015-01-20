#!/usr/bin/env python

"""This script solves the Project Euler problem "Largest palindrome product".
The problem is: Find the largest palindrome made from the product of two
3-digit numbers.
"""

from __future__ import division
import argparse


def main(args):
    """Largest palindrome product"""

    high_num = pow(10, args.digits)
    low_num = pow(10, args.digits - 1)

    max = 0

    for num1 in reversed(range(low_num, high_num)):
        num2 = num1
        decrease = 1
        if num1 % 11:
            num2 = num2 // 11 * 11
            decrease = 11
        while num2 >= low_num:
            product = num1 * num2
            if product > max and is_palindrome(product):
                max = product
            num2 = num2 - decrease

    print(max)


def is_palindrome(number):
    """Check if number is palindrome"""

    return number == int(str(number)[::-1])

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Largest palindrome product')
    parser.add_argument(
        'digits', metavar='DIGITS', type=int, default=3, nargs='?',
        help='Number of digits in numbers to multiply')
    args = parser.parse_args()

    main(args)
