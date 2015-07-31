#!/usr/bin/env python

"""This script solves the Project Euler problem "Spiral primes". The problem
is: What is the sum of the numbers on the diagonals in a 1001 by 1001
spiral formed in the same way?
"""

from __future__ import division
import math


def main():
    """Spiral primes"""

    prime_diagonals = 0
    total_diagonals = 0

    width = 1
    increment = 0
    number = 1

    while total_diagonals == 0 or prime_diagonals / total_diagonals > 0.1:
        width += 2
        increment += 2
        total_diagonals += 4
        for _ in range(4):
            number += increment
            if is_prime(number):
                prime_diagonals += 1

    print(width)


def is_prime(num):
    """Test if number is prime"""

    if num == 1:      # 1 isn't prime
        return False
    if num < 4:       # 2 and 3 are prime
        return True
    if num % 2 == 0:  # Odd numbers aren't prime
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
    main()
