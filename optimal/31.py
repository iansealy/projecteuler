#!/usr/bin/env python

"""This script solves the Project Euler problem "Coin sums". The problem is:
How many different ways can 200p be made using any number of coins?
"""


def main():
    """Coin sums"""

    # Constants
    COINS = (1, 2, 5, 10, 20, 50, 100, 200)
    TARGET = 200

    ways = [0] * (TARGET + 1)
    ways[0] = 1

    for coin in COINS:
        for i in range(coin, TARGET + 1):
            ways[i] += ways[i - coin]

    print(ways[TARGET])

if __name__ == '__main__':
    main()
