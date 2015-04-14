#!/usr/bin/env python

"""This script solves the Project Euler problem "1000-digit Fibonacci number".
The problem is: What is the first term in the Fibonacci sequence to contain
1000 digits?
"""

import argparse


def main(args):
    """1000-digit Fibonacci number"""

    ordinal = 1
    fib1 = [1]
    fib2 = [1]
    while len(fib1) < args.digits:
        ordinal += 1
        carry = 0
        sum = []
        for digit in range(len(fib2)):
            try:
                fib1_digit = fib1[digit]
            except IndexError:
                fib1_digit = 0
            digit_sum = fib2[digit] + fib1_digit + carry
            sum.append(int(str(digit_sum)[-1]))
            if digit_sum >= 10:
                carry = int(str(digit_sum)[:-1])
            else:
                carry = 0
        if carry:
            sum.extend([int(i) for i in str(carry)])
        fib1 = fib2
        fib2 = sum

    print(ordinal)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='1000-digit Fibonacci number')
    parser.add_argument(
        'digits', metavar='DIGITS', type=int, default=1000, nargs='?',
        help='The number of digits')
    args = parser.parse_args()

    main(args)
