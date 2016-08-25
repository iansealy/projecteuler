#!/usr/bin/env python

"""This script solves the Project Euler problem "Square remainders". The
problem is: For 3 <= a <= 1000, find sum rmax.
"""


def main():
    """Square remainders"""

    print(sum(a * (a - 2 + a % 2) for a in range(3, 1001)))

if __name__ == '__main__':
    main()
