#!/usr/bin/env python

"""This script solves the Project Euler problem "Self powers, and
hexagonal". The problem is: Find the last ten digits of the series,
1^1 + 2^2 + 3^3 + ... + 1000^1000.
"""

from __future__ import division


def main():
    """Self powers"""

    # Constants
    NUM_DIGITS = 10
    LAST_NUMBER = 1000

    sum_end = 0
    for number in range(1, LAST_NUMBER + 1):
        power_end = number
        for _ in range(number - 1):
            power_end *= number
            power_end = int(str(power_end)[-NUM_DIGITS:])
        sum_end += power_end
        sum_end = int(str(sum_end)[-NUM_DIGITS:])

    print("{:010d}".format(sum_end))

if __name__ == '__main__':
    main()
