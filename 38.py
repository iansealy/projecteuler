#!/usr/bin/env python

"""This script solves the Project Euler problem "Pandigital multiples". The
problem is: What is the largest 1 to 9 pandigital 9-digit number that can be
formed as the concatenated product of an integer with (1,2, ... , n) where n >
1?
"""


def main():
    """Pandigital multiples"""

    max_pandigital = 0
    number = 0
    got_max = False
    while not got_max:
        number += 1
        if '0' in str(number):
            continue
        n = 1
        while True:
            n += 1
            concat_product = str(number)
            for multiple in range(2, n + 1):
                concat_product += str(multiple * number)
            if len(concat_product) < 9:
                continue
            if len(concat_product) > 9 and n == 2:
                got_max = True
                break
            if len(concat_product) > 9:
                break
            if '0' in concat_product:
                continue
            digits = set(i for i in concat_product)
            if len(digits) != 9:
                continue
            if int(concat_product) > max_pandigital:
                max_pandigital = int(concat_product)

    print(max_pandigital)

if __name__ == '__main__':
    main()
