#!/usr/bin/env python

"""This script solves the Project Euler problem "Pandigital Fibonacci ends".
The problem is: Given that Fk is the first Fibonacci number for which the first
nine digits AND the last nine digits are 1-9 pandigital, find k.
"""

import math


def main():
    """Pandigital Fibonacci ends"""

    # Constants
    TRUNCATE = 1e10
    LOG_PHI = math.log((1 + math.sqrt(5)) / 2, 10)
    LOG_ROOT5 = math.log(5, 10) / 2

    k = 2
    fib1 = 1
    fib2 = 1
    while True:
        k += 1
        sum = fib1 + fib2
        fib1 = fib2 % TRUNCATE
        fib2 = sum % TRUNCATE
        if not is_pandigital(fib2):
            continue
        log_fibk = k * LOG_PHI - LOG_ROOT5
        fibk = int(pow(10, log_fibk - math.floor(log_fibk)) * pow(10, 8))
        if is_pandigital(fibk):
            break

    print(k)


def is_pandigital(num):
    digits = set(i for i in str(num))
    if len(digits) == len(str(num)):
        return True
    else:
        return False

if __name__ == '__main__':
    main()
