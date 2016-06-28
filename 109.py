#!/usr/bin/env python

"""This script solves the Project Euler problem "Darts". The problem is: How
many distinct ways can a player checkout with a score less than 100?
"""


def main():
    """Darts"""

    # Constants
    SINGLES = list(range(1, 21))
    SINGLES.append(25)
    DOUBLES = [2 * n for n in SINGLES]
    TREBLES = [3 * n for n in range(1, 21)]
    ALL = sorted(SINGLES + DOUBLES + TREBLES)
    MAX = 100
    UPPER = 170

    ways = [0] * (UPPER + 1)

    # One dart
    for double in DOUBLES:
        ways[double] += 1

    # Two darts
    for dart1 in ALL:
        for double in DOUBLES:
            ways[dart1 + double] += 1

    # Three darts
    for idx1, dart1 in enumerate(ALL):
        for idx2, dart2 in enumerate(ALL):
            if idx2 < idx1:
                continue
            for double in DOUBLES:
                ways[dart1 + dart2 + double] += 1

    print(sum(ways[1:MAX]))


def polynomial(n):
    return (1 - n + n**2 - n**3 + n**4 - n**5 +
            n**6 - n**7 + n**8 - n**9 + n**10)

if __name__ == '__main__':
    main()
