#!/usr/bin/env python

"""This script solves the Project Euler problem "Combinatoric selections". The
problem is: How many, not necessarily distinct, values of  nCr, for
1 <= n <= 100, are greater than one-million?
"""


def main():
    """Combinatoric selections"""

    # Constants
    N = 100

    greater_count = 0
    r = 0
    n = N
    combs = 1
    while r < n / 2:
        c_right = combs * (n - r) / (r + 1)
        if c_right <= 1000000:
            r += 1
            combs = c_right
        else:
            c_up_right = combs * (n - r) / n
            greater_count += n - 2 * r - 1
            n -= 1
            combs = c_up_right

    print(greater_count)

if __name__ == '__main__':
    main()
