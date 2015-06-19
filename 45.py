#!/usr/bin/env python

"""This script solves the Project Euler problem "Triangular, pentagonal, and
hexagonal". The problem is: Find the next triangle number that is also
pentagonal and hexagonal.
"""

from __future__ import division


def main():
    """Triangular, pentagonal, and hexagonal"""

    # Constants
    KNOWN = 40755

    limit = 10000
    number_count = {}
    n = [1, 1, 1]
    last_number = [1, 1, 1]
    functions = [
        lambda n: n * (n + 1) // 2,
        lambda n: n * (3 * n - 1) // 2,
        lambda n: n * (2 * n - 1)
    ]
    match = []

    while not match:
        limit *= 10
        for i in range(3):
            while last_number[i] < limit:
                n[i] += 1
                last_number[i] = functions[i](n[i])
                if last_number[i] not in number_count:
                    number_count[last_number[i]] = 0
                number_count[last_number[i]] += 1
        match = [num for num, count in number_count.items()
                 if count == 3 and num != KNOWN]

    print(match[0])

if __name__ == '__main__':
    main()
