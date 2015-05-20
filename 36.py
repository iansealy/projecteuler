#!/usr/bin/env python

"""This script solves the Project Euler problem "Double-base palindromes". The
problem is: Find the sum of all numbers, less than one million, which are
palindromic in base 10 and base 2.
"""


def main():
    """Double-base palindromes"""

    # Constants
    MAX = 1000000

    total = sum([num for num in range(1, MAX) if is_dec_bin_palindrome(num)])

    print(total)


def is_dec_bin_palindrome(number):
    """Check if number is palindrome in both decimal and binary"""

    if number != int(str(number)[::-1]):
        return False
    binary = "{:b}".format(number)
    if binary != binary[::-1]:
        return False
    return True

if __name__ == '__main__':
    main()
