#!/usr/bin/env python

"""This script solves the Project Euler problem "Maximum path sum II". The
problem is: Find the maximum total from top to bottom in triangle.txt, a 15K
text file containing a triangle with one-hundred rows.
"""

try:
    from urllib.request import urlopen
except ImportError:
    from urllib import urlopen


def main():
    """Maximum path sum II"""

    # Constants
    URL = 'https://projecteuler.net/project/resources/p067_triangle.txt'

    # Prepare triangle
    triangle = [[int(i) for i in line.split()] for line in urlopen(URL)]

    for i in range(len(triangle) - 2, -1, -1):
        for j in range(len(triangle[i])):
            triangle[i][j] += max(triangle[i+1][j], triangle[i+1][j+1])

    print(triangle[0][0])

if __name__ == '__main__':
    main()
