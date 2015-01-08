#!/usr/bin/env python

"""This script solves the Project Euler problem "Even Fibonacci numbers". The
problem is: By considering the terms in the Fibonacci sequence whose values do
not exceed four million, find the sum of the even-valued terms.
"""


def main():
    """Even Fibonacci numbers"""

    # Constants
    MAX_FIB = 4000000

    fib_even1 = 0
    fib_even2 = 2
    sum_even = 0

    while fib_even2 < MAX_FIB:
        fib_even1, fib_even2 = fib_even2, 4 * fib_even2 + fib_even1
        sum_even += fib_even1

    print(sum_even)

if __name__ == '__main__':
    main()
