#!/usr/bin/env python

"""This script solves the Project Euler problem "Longest Collatz sequence". The
problem is: Which starting number, under one million, produces the longest
chain?
"""

import argparse


def main(args):
    """Longest Collatz sequence"""

    cache = {}

    longest_chain_length = 0
    longest_chain_start = 1

    for start in range(2, args.limit):
        length = 0
        number = start
        while number > 1:
            # Check if rest of chain is cached
            if number in cache:
                length += cache[number]
                break

            length += 1
            if number % 2:
                number = 3 * number + 1
            else:
                number /= 2
        cache[start] = length
        if length > longest_chain_length:
            longest_chain_length = length
            longest_chain_start = start

    print(longest_chain_start)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Longest Collatz sequence')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=1000000, nargs='?',
        help='The number below which to find the longest Collatz sequence')
    args = parser.parse_args()

    main(args)
