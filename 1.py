#!/usr/bin/env python

"""This script solves the Project Euler problem "Multiples of 3 and 5". The
problem is: Find the sum of all the multiples of 3 or 5 below 1000.
"""


def main():
    """Multiples of 3 and 5"""

    # Constants
    MAX_NUM = 1000

    print(sum([i for i in range(MAX_NUM) if i % 3 == 0 or i % 5 == 0]))

if __name__ == '__main__':
    main()
