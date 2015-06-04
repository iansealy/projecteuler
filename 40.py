#!/usr/bin/env python

"""This script solves the Project Euler problem "Champernowne's constant". The
problem is: If dn represents the nth digit of the fractional part, find the
value of the following expression.
d1 x d10 x d100 x d1000 x d10000 x d100000 x d1000000
"""

from __future__ import division


def main():
    """Champernowne's constant"""

    print(get_digit(1) * get_digit(10) * get_digit(100) * get_digit(1000) *
          get_digit(10000) * get_digit(100000) * get_digit(1000000))


def get_digit(n):
    num_digits = 1
    range_start = 1
    range_end = 9
    while range_end < n:
        num_digits += 1
        range_start = range_end + 1
        range_end += num_digits * 9 * pow(10, num_digits - 1)
    range_ordinal = (n - range_start) // num_digits
    first_in_range = pow(10, num_digits - 1)
    number = first_in_range + range_ordinal
    digit_ordinal = range_ordinal % num_digits
    digit = int(str(number)[digit_ordinal:digit_ordinal+1])

    return digit

if __name__ == '__main__':
    main()
