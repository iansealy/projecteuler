#!/usr/bin/env python

"""This script solves the Project Euler problem "Arranged probability". The
problem is: By finding the first arrangement to contain over 1012 =
1,000,000,000,000 discs in total, determine the number of blue discs that the
box would contain.
"""


def main():
    """Arranged probability"""

    # Constants
    LIMIT = 1e12

    blue = 85
    num = blue + 35
    while num <= LIMIT:
        blue, num = 3 * blue + 2 * num - 2, 4 * blue + 3 * num - 3

    print(blue)

if __name__ == '__main__':
    main()
