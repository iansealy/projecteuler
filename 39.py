#!/usr/bin/env python

"""This script solves the Project Euler problem "Integer right triangles". The
problem is: For which value of p <= 1000, is the number of solutions maximised?
"""

from __future__ import division
from collections import defaultdict
import math


def main():
    """Integer right triangles"""

    # Constants
    MAX_SIDE = int(1000 / 2 + 1)

    count = defaultdict(int)

    for side1 in range(1, MAX_SIDE):
        for side2 in range(side1, MAX_SIDE):
            side3 = math.sqrt(side1 * side1 + side2 * side2)
            if int(side3) == side3:
                count[side1 + side2 + int(side3)] += 1

    print(max(count, key=count.get))

if __name__ == '__main__':
    main()
