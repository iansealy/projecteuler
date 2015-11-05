#!/usr/bin/env python

"""This script solves the Project Euler problem "Counting rectangles". The
problem is: Although there exists no rectangular grid that contains exactly two
million rectangles, find the area of the grid with the nearest solution.
"""


def main():
    """Counting rectangles"""

    # Constants
    TARGET = 2000000

    triangle = [0]
    n = 0
    while triangle[n] < TARGET:
        n += 1
        triangle.append(n * (n + 1) / 2)

    closest_area = 0
    closest_diff = TARGET
    for i in range(1, len(triangle)):
        for j in range(i, len(triangle)):
            rectangles = triangle[i] * triangle[j]
            if abs(rectangles - TARGET) < closest_diff:
                closest_diff = abs(rectangles - TARGET)
                closest_area = i * j

    print(closest_area)

if __name__ == '__main__':
    main()
