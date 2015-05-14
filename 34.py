#!/usr/bin/env python

"""This script solves the Project Euler problem "Digit factorials". The problem
is: Find the sum of all numbers which are equal to the sum of the factorial of
their digits.
"""

import math


def main():
    """Digit factorials"""

    factorial_of = [math.factorial(i) for i in range(0, 10)]

    total = 0
    for number in range(10, factorial_of[9] * 7 + 1):
        if number == sum([factorial_of[int(digit)] for digit in str(number)]):
            total += number

    print(total)

if __name__ == '__main__':
    main()
