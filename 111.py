#!/usr/bin/env python

"""This script solves the Project Euler problem "Primes with runs".
The problem is: Find the sum of all S(10, d).
"""

import argparse
import math
from itertools import combinations, product


def main(args):
    """Primes with runs"""

    total = 0
    for d in range(10):
        other_digits = [i for i in range(10) if i != d]
        non_rep_digits = 0
        while True:
            non_rep_digits += 1
            primes = []
            base = str(d) * args.n
            for comb in combinations(range(args.n), non_rep_digits):
                for perm in product(other_digits, repeat=non_rep_digits):
                    num = list(base)
                    for i in range(non_rep_digits):
                        num[comb[i]] = str(perm[i])
                    if num[0] == '0':
                        continue
                    num = int(''.join(num))
                    if is_prime(num):
                        primes.append(num)
            if primes:
                total += sum(primes)
                break

    print(total)


def is_prime(num):
    """Test if number is prime"""

    if num == 1:      # 1 isn't prime
        return False
    if num < 4:       # 2 and 3 are prime
        return True
    if num % 2 == 0:  # Even numbers aren't prime
        return False
    if num < 9:       # 5 and 7 are prime
        return True
    if num % 3 == 0:  # Numbers divisible by 3 aren't prime
        return False

    num_sqrt = int(math.sqrt(num))
    factor = 5
    while factor <= num_sqrt:
        if num % factor == 0:        # Primes greater than three are 6k-1
            return False
        if num % (factor + 2) == 0:  # Or 6k+1
            return False
        factor += 6
    return True

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Primes with runs')
    parser.add_argument(
        'n', metavar='N', type=int, default=10, nargs='?',
        help='The number of digits in the primes')
    args = parser.parse_args()

    main(args)
