#!/usr/bin/env python

"""This script solves the Project Euler problem "Path sum: two ways".
The problem is: Find the minimal path sum, in matrix.txt, a 31K text file
containing a 80 by 80 matrix, from the top left to the bottom right by only
moving right and down.
"""

import argparse
import csv
try:
    from urllib.request import urlopen
except ImportError:
    from urllib import urlopen
try:
    from io import StringIO
except ImportError:
    from StringIO import StringIO


def main(args):
    """Path sum: two ways"""

    response = urlopen(args.url)
    matrix = response.read()
    matrix = [[int(i) for i in row]
              for row in csv.reader(StringIO(matrix.decode('utf-8')))]

    rows = len(matrix)
    cols = len(matrix[0])
    s = [[float('Inf') for j in range(cols + 1)] for i in range(rows + 1)]
    s[1][0] = 0
    s[0][1] = 0

    for i in range(1, rows + 1):
        for j in range(1, cols + 1):
            s[i][j] = matrix[i - 1][j - 1]
            if s[i - 1][j] < s[i][j - 1]:
                s[i][j] += s[i - 1][j]
            else:
                s[i][j] += s[i][j - 1]

    print(s[rows][cols])


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Coin partitions')
    parser.add_argument(
        'url', metavar='URL', type=str,
        default='https://projecteuler.net/project/resources/p081_matrix.txt',
        nargs='?', help='Matrix URL')
    args = parser.parse_args()

    main(args)
