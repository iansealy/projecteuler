#!/usr/bin/env python

"""This script solves the Project Euler problem "10001st prime". The problem
is: What is the 10 001st prime number?
"""

import argparse
import math


def main(args):
    """10001st prime"""

    primes = set([2, 3])
    num = 5
    primes_got = 2

    while primes_got < args.ordinal:
        is_prime = True
        num_sqrt = int(math.sqrt(num))
        for prime in sorted(primes):
            if prime > num_sqrt:
                break
            if num % prime == 0:
                is_prime = False
                break
        if is_prime:
            primes.add(num)
            primes_got += 1
        num += 2

    print(max(primes))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='10001st prime')
    parser.add_argument(
        'ordinal', metavar='ORDINAL', type=int, default=10001, nargs='?',
        help='The ordinal of the required prime')
    args = parser.parse_args()

    main(args)
