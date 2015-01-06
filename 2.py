#!/usr/bin/env python

"""This script solves the Project Euler problem "Even Fibonacci numbers". The
problem is: By considering the terms in the Fibonacci sequence whose values do
not exceed four million, find the sum of the even-valued terms.
"""


def main():
    """Even Fibonacci numbers"""

    # Constants
    MAX_FIB = 4000000

    fib1 = fib2 = 1
    sum_even = 0

    while fib2 < MAX_FIB:
        fib1, fib2 = fib2, fib1 + fib2
        if fib1 % 2 == 0:
            sum_even += fib1

    print(sum_even)

if __name__ == '__main__':
    main()
