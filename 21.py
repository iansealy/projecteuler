#!/usr/bin/env python

"""This script solves the Project Euler problem "Amicable numbers". The problem
is: Evaluate the sum of all the amicable numbers under 10000.
"""

import argparse
import math


def main(args):
    """Amicable numbers"""

    divisor_sum = {i: sum_divisors(i) for i in range(1, args.limit)}

    sum = 0

    for num in range(2, args.limit):
        if divisor_sum[num] >= args.limit or divisor_sum[num] == num:
            continue
        if divisor_sum[divisor_sum[num]] == num:
            sum += num

    print(sum)


def sum_divisors(number):
    """Sum all proper divisors of a number"""

    sum = 1

    for i in range(2, int(math.sqrt(number))):
        if number % i == 0:
            sum += i + number / i

    return(sum)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Amicable numbers')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=10000, nargs='?',
        help='The maximum amicable number')
    args = parser.parse_args()

    main(args)
