#!/usr/bin/env python

"""This script solves the Project Euler problem "Su Doku". The problem
is: By solving all fifty puzzles find the sum of the 3-digit numbers found in
the top left corner of each solution grid; for example, 483 is the 3-digit
number found in the top left corner of the solution grid above.
"""

from __future__ import division
try:
    from urllib.request import urlopen
except ImportError:
    from urllib import urlopen
from collections import defaultdict


def main():
    """Su Doku"""

    # Constants
    URL = 'https://projecteuler.net/project/resources/p096_sudoku.txt'
    global LAST
    LAST = 9 * 9 - 1
    global BOX_STARTS
    BOX_STARTS = [0, 3, 6, 27, 30, 33, 54, 57, 60]

    # Prepare grids
    sudokus = []
    sudoku = []
    for line in urlopen(URL):
        line = line.rstrip().decode('ascii')
        if line.find('Grid') == 0:
            if sudoku:
                sudokus.append(sudoku)
                sudoku = []
        else:
            sudoku.extend(int(digit) for digit in line)
    sudokus.append(sudoku)

    total = 0
    for sudoku in sudokus:
        sudoku = solve(sudoku)
        total += int('{}{}{}'.format(sudoku[0], sudoku[1], sudoku[2]))

    print(total)


def solve(sudoku):
    prev_sum = sum(sudoku)
    while True:
        sudoku = check_candidates(sudoku)
        sudoku = find_places(sudoku)
        new_sum = sum(sudoku)
        if prev_sum == new_sum:
            break
        prev_sum = new_sum
    sudoku = brute_force(sudoku)

    return(sudoku)


def check_candidates(sudoku):
    for cell in range(0, LAST + 1):
        if sudoku[cell]:
            continue
        possibles = possible(cell, sudoku)
        if len(possibles) == 1:
            sudoku[cell] = possibles[0]

    return sudoku


def find_places(sudoku):
    cells = []

    cells.extend(col(col_start) for col_start in row(0))
    cells.extend(row(row_start) for row_start in col(0))
    cells.extend(box(box_start) for box_start in BOX_STARTS)

    for cell_set in cells:
        place = defaultdict(set)
        for cell in cell_set:
            if sudoku[cell]:
                continue
            for poss in possible(cell, sudoku):
                place[poss].add(cell)
        try:
            possibles = place.iterkeys()
        except AttributeError:
            possibles = place.keys()
        for poss in possibles:
            if len(place[poss]) == 1:
                cell = place[poss].pop()
                sudoku[cell] = poss

    return sudoku


def brute_force(sudoku):
    for cell in range(0, LAST + 1):
        if sudoku[cell]:
            continue
        for poss in possible(cell, sudoku):
            candidate_sudoku = list(sudoku)
            candidate_sudoku[cell] = poss
            candidate_sudoku = brute_force(candidate_sudoku)
            if candidate_sudoku is not None:
                return candidate_sudoku
        return None

    return sudoku


def possible(cell, sudoku):
    possible = set(range(1, 10))

    adjacent_cells = []
    adjacent_cells.extend(row(cell))
    adjacent_cells.extend(col(cell))
    adjacent_cells.extend(box(cell))
    for adj_cell in adjacent_cells:
        if sudoku[adj_cell]:
            possible.discard(sudoku[adj_cell])

    return sorted(possible)


def row(cell):
    row_start = (cell // 9) * 9

    return range(row_start, row_start + 9)


def col(cell):
    col_start = cell % 9

    col = []
    i = 0
    while len(col) < 9:
        col.append(col_start + i * 9)
        i += 1

    return col


def box(cell):
    box_start = 27 * (cell // 27) + 3 * ((cell % 9) // 3)

    box = []
    box.extend(range(box_start, box_start + 3))
    box.extend(range(box_start + 9, box_start + 12))
    box.extend(range(box_start + 18, box_start + 21))

    return box

if __name__ == '__main__':
    main()
