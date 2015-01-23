#!/usr/bin/env python

"""This script solves the Project Euler problem "Smallest multiple". The
problem is: What is the smallest positive number that is evenly divisible by
all of the numbers from 1 to 20?
"""

import argparse
from collections import defaultdict
import math


def main(args):
    """Smallest multiple"""

    multiple_count_for = defaultdict(int)

    for num in range(2, args.max_num):
        count_for = get_factors(num)
        for factor, count in count_for.items():
            if count > multiple_count_for[factor]:
                multiple_count_for[factor] = count

    min_multiple = 1
    for factor, count in multiple_count_for.items():
        min_multiple *= factor ** count

    print(min_multiple)


def get_factors(number):
    """Get prime factors of a number"""

    count_for = defaultdict(int)

    div = 2
    while div <= int(math.sqrt(number)):
        while number % div == 0:
            number = number // div
            count_for[div] += 1

        # Don't bother testing even numbers (except two)
        if div > 2:
            div += 2
        else:
            div += 1

    if number > 1:
        count_for[number] += 1

    return count_for

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Smallest multiple')
    parser.add_argument(
        'max_num', metavar='MAXNUM', type=int, default=20, nargs='?',
        help='The number ending the sequence to find the smallest multiple of')
    args = parser.parse_args()

    main(args)
