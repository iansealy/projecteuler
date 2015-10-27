#!/usr/bin/env python

"""This script solves the Project Euler problem "Path sum: three ways". The
problem is: Find the minimal path sum, in matrix.txt, a 31K text file
containing a 80 by 80 matrix, from the left column to the right column.
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
    """Path sum: three ways"""

    response = urlopen(args.url)
    matrix = response.read()
    matrix = [[int(i) for i in row]
              for row in csv.reader(StringIO(matrix.decode('utf-8')))]

    rows = len(matrix)
    cols = len(matrix[0])
    s = [[matrix[i][j] for j in range(cols)] for i in range(rows)]

    for j in range(1, cols):
        s[0][j] = s[0][j - 1] + matrix[0][j]
        for i in range(1, rows):
            if s[i][j - 1] < s[i - 1][j]:
                s[i][j] = s[i][j - 1] + matrix[i][j]
            else:
                s[i][j] = s[i - 1][j] + matrix[i][j]
        for i in reversed(range(rows - 1)):
            if s[i][j] > s[i + 1][j] + matrix[i][j]:
                s[i][j] = s[i + 1][j] + matrix[i][j]

    print(min(s[i][-1] for i in range(rows)))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Path sum: three ways')
    parser.add_argument(
        'url', metavar='URL', type=str,
        default='https://projecteuler.net/project/resources/p082_matrix.txt',
        nargs='?', help='Matrix URL')
    args = parser.parse_args()

    main(args)
