#!/usr/bin/env python

"""This script solves the Project Euler problem "Permuted multiples". The
problem is: Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x,
and 6x, contain the same digits.
"""


def main():
    """Permuted multiples"""

    num = 0
    while True:
        num += 1
        if str(num)[0:1] != '1':
            continue
        digits = ''.join(sorted([d for d in str(num)]))
        all_match = True
        for multiple in range(2, 7):
            multiple_digits = ''.join(sorted([d for d in str(num * multiple)]))
            if digits != multiple_digits:
                all_match = False
                break
        if all_match:
            break
    print(num)

if __name__ == '__main__':
    main()
