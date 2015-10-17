#!/usr/bin/env python

"""This script solves the Project Euler problem "Passcode derivation". The
problem is: Given that the three characters are always asked for in order,
analyse the file so as to determine the shortest possible secret passcode of
unknown length.
"""

try:
    from urllib.request import urlopen
except ImportError:
    from urllib import urlopen
from collections import defaultdict


def main():
    """Passcode derivation"""

    # Constants
    URL = 'https://projecteuler.net/project/resources/p079_keylog.txt'

    # Prepare triangle
    triplets = [line.rstrip().decode('ascii') for line in urlopen(URL)]

    after = defaultdict(set)
    for triplet in triplets:
        digit1, digit2, digit3 = list(triplet)
        after[digit1].add(digit2)
        after[digit1].add(digit3)
        after[digit2].add(digit3)
        after[digit3]

    print(''.join(sorted(after, key=lambda digit: len(after[digit]),
                         reverse=True)))

if __name__ == '__main__':
    main()
