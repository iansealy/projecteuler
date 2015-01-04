#!/usr/bin/env python

"""This script solves the Project Euler problem "Multiples of 3 and 5". The
problem is: Find the sum of all the multiples of 3 or 5 below 1000.
"""

from __future__ import division

# Constants
MAX_NUM = 1000


def main():
    """Multiples of 3 and 5"""

    print(sum_sequence(3) + sum_sequence(5) - sum_sequence(15))


def sum_sequence(step):
    """Sum sequence n + 2n + 3n + ... + (MAX_NUM-1)//n"""

    last_int = (MAX_NUM - 1) // step

    return step * last_int * (last_int + 1) // 2

if __name__ == '__main__':
    main()
