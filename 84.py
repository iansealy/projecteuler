#!/usr/bin/env python

"""This script solves the Project Euler problem "Monopoly odds". The problem
is: If, instead of using two 6-sided dice, two 4-sided dice are used, find the
six-digit modal string.
"""

import argparse
import random


def main(args):
    """Monopoly odds"""

    # Constants
    SQUARES  = 40
    CC_CARDS = 16
    CH_CARDS = 16
    GO       = 0
    A1       = 1
    CC1      = 2
    A2       = 3
    T1       = 4
    R1       = 5
    B1       = 6
    CH1      = 7
    B2       = 8
    B3       = 9
    JAIL     = 10
    C1       = 11
    U1       = 12
    C2       = 13
    C3       = 14
    R2       = 15
    D1       = 16
    CC2      = 17
    D2       = 18
    D3       = 19
    FP       = 20
    E1       = 21
    CH2      = 22
    E2       = 23
    E3       = 24
    R3       = 25
    F1       = 26
    F2       = 27
    U2       = 28
    F3       = 29
    G2J      = 30
    G1       = 31
    G2       = 32
    CC3      = 33
    G3       = 34
    R4       = 35
    CH3      = 36
    H1       = 37
    T2       = 38
    H2       = 39

    count = [0] * SQUARES
    current = GO
    double_run = 0

    for _ in range(int(1e7)):
        die1 = random.randrange(args.sides) + 1
        die2 = random.randrange(args.sides) + 1
        if die1 == die2:
            double_run += 1
        else:
            double_run = 0
        current = (current + die1 + die2) % SQUARES

        if double_run == 3:
            current = JAIL
            double_run = 0

        if current == G2J:
            current = JAIL

        if current in (CC1, CC2, CC3):
            cc = random.randrange(CC_CARDS) + 1
            if cc == 1:
                current = GO
            elif cc == 2:
                current = JAIL

        if current in (CH1, CH2, CH3):
            ch = random.randrange(CH_CARDS) + 1
            if ch == 1:
                current = GO
            elif ch == 2:
                current = JAIL
            elif ch == 3:
                current = C1
            elif ch == 4:
                current = E3
            elif ch == 5:
                current = H2
            elif ch == 6:
                current = R1
            elif (ch == 7 or ch == 8) and current == CH1:
                current = R2
            elif (ch == 7 or ch == 8) and current == CH2:
                current = R3
            elif (ch == 7 or ch == 8) and current == CH3:
                current = R1
            elif ch == 9 and current in (CH1, CH3):
                current = U1
            elif ch == 10:
                current = (current - 3) % SQUARES

        count[current] += 1

    top = list(range(SQUARES))
    top.sort(key=lambda i: count[i], reverse=True)
    top = top[0:3]

    print('{0[0]:02d}{0[1]:02d}{0[2]:02d}'.format(top))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Monopoly odds')
    parser.add_argument(
        'sides', metavar='SIDES', type=int, default=4, nargs='?',
        help='Number of die sides')
    args = parser.parse_args()

    main(args)
