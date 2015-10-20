#!/usr/bin/env python

"""This script solves the Project Euler problem "Square root digital
expansion". The problem is: For the first one hundred natural numbers, find the
total of the digital sums of the first one hundred decimal digits for all the
irrational square roots.
"""

import math


def main():
    """Square root digital expansion"""

    total = 0
    current_square = 0
    for num in range(1, 101):
        if math.sqrt(num) == math.floor(math.sqrt(num)):
            current_square = num
            continue
        sqrt = int(math.sqrt(current_square))
        div = (num - current_square) * 100
        while len(str(sqrt)) < 100:
            double = sqrt * 2
            i = 0
            while (True):
                i += 1
                if (double * 10 + i) * i > div:
                    i -= 1
                    break
            sqrt = sqrt * 10 + i
            div = (div - (double * 10 + i) * i) * 100
        total += sum(int(i) for i in str(sqrt))

    print(total)

if __name__ == '__main__':
    main()
