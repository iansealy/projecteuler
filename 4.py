#!/usr/bin/env python

"""This script solves the Project Euler problem "Largest palindrome product".
The problem is: Find the largest palindrome made from the product of two
3-digit numbers.
"""

import argparse


def main(args):
    """Largest palindrome product"""

    high_num = pow(10, args.digits)

    max = 0

    for num1 in reversed(range(high_num)):
        for num2 in reversed(range(high_num)):
            if num2 <= num1:
                product = num1 * num2
                if is_palindrome(product) and product > max:
                    max = product

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
