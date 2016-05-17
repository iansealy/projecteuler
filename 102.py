#!/usr/bin/env python

"""This script solves the Project Euler problem "Triangle containment". The
problem is: Using triangles.txt, a 27K text file containing the co-ordinates of
one thousand "random" triangles, find the number of triangles for which the
interior contains the origin.
"""

from __future__ import division
try:
    from urllib.request import urlopen
except ImportError:
    from urllib import urlopen


def main():
    """Triangle containment"""

    # Constants
    URL = 'https://projecteuler.net/project/resources/p102_triangles.txt'

    contains_origin = 0
    for line in urlopen(URL):
        x1, y1, x2, y2, x3, y3 = [int(i) for i in
                                  line.rstrip().decode('ascii').split(',')]
        total_area = area(x1, y1, x2, y2, x3, y3)
        area1 = area(0, 0, x2, y2, x3, y3)
        area2 = area(x1, y1, 0, 0, x3, y3)
        area3 = area(x1, y1, x2, y2, 0, 0)
        if area1 + area2 + area3 == total_area:
            contains_origin += 1

    print(contains_origin)


def area(x1, y1, x2, y2, x3, y3):
    return abs(x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2) / 2)

if __name__ == '__main__':
    main()
