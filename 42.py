#!/usr/bin/env python

"""This script solves the Project Euler problem "Coded triangle numbers". The
problem is: Using words.txt, a 16K text file containing nearly two-thousand
common English words, how many are triangle words?
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
    """Coded triangle number"""

    # Constants
    WORDS_URL = 'https://projecteuler.net/project/resources/p042_words.txt'

    response = urlopen(WORDS_URL)
    words = response.read()
    words = [row for row in csv.reader(StringIO(words.decode('utf-8')))][0]

    triangles = [1]
    n = 2
    while max(triangles) < 1000:
        triangles.append(n * (n + 1) / 2)
        n += 1

    count = 0
    for word in words:
        value = sum([ord(letter) - 64 for letter in word])
        if value in triangles:
            count += 1

    print(count)

if __name__ == '__main__':
    main()
