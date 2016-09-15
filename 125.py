#!/usr/bin/env python

"""This script solves the Project Euler problem "Palindromic sums". The problem
is: Find the sum of all the numbers less than 10^8 that are both palindromic
and can be written as the sum of consecutive squares.
"""

import argparse


def main(args):
    """Palindromic sums"""

    squares = [1]
    n = 1
    while squares[-1] < args.limit:
        n += 1
        squares.append(n * n)

    square_sums = set()
    for start in range(1, len(squares)):
        square_sum = squares[start - 1]
        n = start + 1
        while n < len(squares):
            square_sum += squares[n - 1]
            if square_sum > args.limit:
                break
            if is_palindrome(square_sum):
                square_sums.add(square_sum)
            n += 1

    print(sum(square_sums))


def is_palindrome(number):
    """Check if number is palindrome"""

    return number == int(str(number)[::-1])

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Palindromic sums')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=100000000, nargs='?',
        help='The maximum number')
    args = parser.parse_args()

    main(args)
