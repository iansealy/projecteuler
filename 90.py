#!/usr/bin/env python

"""This script solves the Project Euler problem "Cube digit pairs". The problem
is: How many distinct arrangements of the two cubes allow for all of the square
numbers to be displayed?
"""

from __future__ import division
import itertools


def main():
    """Cube digit pairs"""

    # Constants
    global SQUARES
    SQUARES = set(['01', '04', '09', '16', '25', '36', '49', '64', '81'])
    DIGITS = ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9')

    distinct = 0
    for comb1 in itertools.combinations(DIGITS, 6):
        for comb2 in itertools.combinations(DIGITS, 6):
            if all_squares(comb1, comb2):
                distinct += 1

    print(distinct // 2)


def all_squares(comb1, comb2):
    """Check if all squares can be produced"""

    comb1 = set(comb1)
    if '6' in comb1 or '9' in comb1:
        comb1.update(['6', '9'])
    comb2 = set(comb2)
    if '6' in comb2 or '9' in comb2:
        comb2.update(['6', '9'])

    products = set([p[0] + p[1] for p in itertools.product(comb1, comb2)])
    products.update([p[1] + p[0] for p in itertools.product(comb1, comb2)])

    if products.issuperset(SQUARES):
        return(True)
    else:
        return(False)

if __name__ == '__main__':
    main()
