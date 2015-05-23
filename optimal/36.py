#!/usr/bin/env python

"""This script solves the Project Euler problem "Double-base palindromes". The
problem is: Find the sum of all numbers, less than one million, which are
palindromic in base 10 and base 2.
"""

from __future__ import division


def main():
    """Double-base palindromes"""

    # Constants
    MAX = 1000000

    total = 0
    i = 1
    p = make_palindrome_base_2(i, True)
    while p < MAX:
        if is_palindrome(p, 10):
            total += p
        i += 1
        p = make_palindrome_base_2(i, True)
    i = 1
    p = make_palindrome_base_2(i, False)
    while p < MAX:
        if is_palindrome(p, 10):
            total += p
        i += 1
        p = make_palindrome_base_2(i, False)

    print(total)


def make_palindrome_base_2(number, odd_length):
    """Get palindrome in base 2"""

    result = number

    if odd_length:
        number >>= 1

    while number > 0:
        result = (result << 1) + (number & 1)
        number >>= 1

    return(result)


def is_palindrome(number, base):
    """Check if number is palindrome in chosen base"""

    reversed = 0
    k = number
    while k > 0:
        reversed = base * reversed + k % base
        k //= base

    return number == reversed

if __name__ == '__main__':
    main()
