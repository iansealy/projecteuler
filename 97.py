#!/usr/bin/env python

"""This script solves the Project Euler problem "Large non-Mersenne prime". The
problem is: Find the last ten digits of this prime number.
"""


def main():
    """Large non-Mersenne prime"""

    # Constants
    POWER = 7830457
    MULTIPLIER = 28433
    DIGITS = 1e10

    num = 1
    for _ in range(POWER):
        num *= 2
        num %= DIGITS

    num *= MULTIPLIER
    num += 1
    num %= DIGITS

    print(int(num))

if __name__ == '__main__':
    main()
