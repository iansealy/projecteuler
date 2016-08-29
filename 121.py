#!/usr/bin/env python

"""This script solves the Project Euler problem "Disc game prize fund". The
problem is: Find the maximum prize fund that should be allocated to a single
game in which fifteen turns are played.
"""

from __future__ import division
import argparse


def main(args):
    """Disc game prize fund"""

    outcomes = []
    prev_outcomes = [1, 1]
    turn = 1
    while turn < args.turns:
        turn += 1
        outcomes = [0] * (turn + 1)
        for blue in range(turn):
            outcomes[blue] += prev_outcomes[blue]
        for red in range(1, turn + 1):
            outcomes[red] += prev_outcomes[red - 1] * turn
        prev_outcomes = outcomes

    total = sum(outcomes)
    num_win = (args.turns + 1) // 2
    win = sum(outcomes[:num_win])
    print(total // win)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Disc game prize fund')
    parser.add_argument(
        'turns', metavar='TURNS', type=int, default=15, nargs='?',
        help='The number of turns')
    args = parser.parse_args()

    main(args)
