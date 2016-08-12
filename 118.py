#!/usr/bin/env python

"""This script solves the Project Euler problem "Pandigital prime sets". The
problem is: How many distinct sets containing each of the digits one through
nine exactly once contain only prime elements?
"""

import math
from itertools import permutations
from collections import defaultdict


def main():
    """Pandigital prime sets"""

    global primes_for
    primes_for = defaultdict(list)
    for digits in range(1, 9):
        for perm in permutations(range(1, 10), digits):
            num = int(''.join(str(i) for i in perm))
            if is_prime(num):
                primes_for[digits].append(num)

    print(sets(9, 0, []))


def sets(max_digits, length, primes):
    digits = set(i for i in ''.join(str(prime) for prime in primes))
    if len(digits) < length:
        return 0

    if length == 9:
        return 1

    count = 0
    for num_digits in range(max_digits, 0, -1):
        if length + num_digits > 9:
            continue
        for prime in primes_for[num_digits]:
            if len(primes) and prime >= primes[-1]:
                break
            new_primes = list(primes)
            new_primes.append(prime)
            count += sets(num_digits, length + num_digits, new_primes)

    return count


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
    main()
