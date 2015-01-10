#!/usr/bin/env python

"""This script solves the Project Euler problem "Largest prime factor". The
problem is: What is the largest prime factor of the number 600851475143 ?
"""

from __future__ import division
import argparse
import math


def main(args):
    """Largest prime factor"""

    number = args.number

    div = 2
    while div <= int(math.sqrt(number)):
        while number % div == 0:
            number = number // div

        # Don't bother testing even numbers (except two)
        if div > 2:
            div += 2
        else:
            div += 1

    print(number)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Largest prime factor')
    parser.add_argument(
        'number', metavar='NUMBER', type=int, default=600851475143, nargs='?',
        help='Number to find the largest prime factor of')
    args = parser.parse_args()

    main(args)
