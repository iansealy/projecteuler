#!/usr/bin/env python

"""This script solves the Project Euler problem "Names scores". The problem is:
What is the total of all the name scores in the file?
"""

import csv
try:
    from urllib.request import urlopen
except ImportError:
    from urllib import urlopen
try:
    from io import StringIO
except ImportError:
    from StringIO import StringIO


def main():
    """Names scores"""

    # Constants
    NAMES_URL = 'https://projecteuler.net/project/resources/p022_names.txt'

    response = urlopen(NAMES_URL)
    names = response.read()
    names = [row for row in csv.reader(StringIO(names.decode('utf-8')))][0]

    total = 0

    for i, name in enumerate(sorted(names), start=1):
        value = sum([ord(letter) - 64 for letter in name])
        total += i * value

    print(total)

if __name__ == '__main__':
    main()
