#!/usr/bin/env python

"""This script solves the Project Euler problem "Smallest multiple". The
problem is: What is the smallest positive number that is evenly divisible by
all of the numbers from 1 to 20?
"""

import argparse
import math


def main(args):
    """Smallest multiple"""

    multiple = 1

    primes = get_primes(args.max_num)

    limit = int(math.sqrt(args.max_num))

    for prime in primes:
        power = 1
        if prime <= limit:
            power = int(math.log(args.max_num) / math.log(prime))
        multiple = multiple * pow(prime, power)

    print(multiple)


def get_primes(limit):
    """Get prime numbers"""

    primes = set([2, 3])
    num = 5

    while num <= limit:
        is_prime = True
        num_sqrt = int(math.sqrt(num))
        for prime in sorted(primes):
            if prime > num_sqrt:
                continue
            if num % prime == 0:
                is_prime = False
                break
        if is_prime:
            primes.add(num)
        num += 2

    return primes

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Smallest multiple')
    parser.add_argument(
        'max_num', metavar='MAXNUM', type=int, default=20, nargs='?',
        help='The number ending the sequence to find the smallest multiple of')
    args = parser.parse_args()

    main(args)
