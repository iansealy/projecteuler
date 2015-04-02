#!/usr/bin/env python

"""This script solves the Project Euler problem "Amicable numbers". The problem
is: Evaluate the sum of all the amicable numbers under 10000.
"""

from __future__ import division
import argparse


def main(args):
    """Amicable numbers"""

    sum = 0

    for a in range(2, args.limit):
        b = sum_proper_divisors(a)
        if b > a:
            if sum_proper_divisors(b) == a:
                sum += a + b

    print(sum)


def sum_proper_divisors(number):
    """Sum all proper divisors of a number"""

    return(sum_divisors(number) - number)


def sum_divisors(number):
    """Sum all divisors of a number"""

    sum = 1
    prime = 2

    while prime * prime <= number and number > 1:
        if number % prime == 0:
            j = prime * prime
            number //= prime
            while number % prime == 0:
                j *= prime
                number //= prime
            sum *= (j - 1)
            sum //= (prime - 1)
        if prime == 2:
            prime = 3
        else:
            prime += 2
    if number > 1:
        sum *= (number + 1)

    return(sum)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Amicable numbers')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=10000, nargs='?',
        help='The maximum amicable number')
    args = parser.parse_args()

    main(args)
