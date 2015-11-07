#!/usr/bin/env python

"""This script solves the Project Euler problem "Coin sums". The problem is:
How many different ways can 200p be made using any number of coins?
"""

try:
    from functools import lru_cache
except ImportError:
    from functools32 import lru_cache


def main():
    """Coin sums"""

    # Constants
    COINS = (200, 100, 50, 20, 10, 5, 2, 1)

    print(change(200, COINS))


@lru_cache()
def change(money, coins):
    """Recursively calculate number of ways to make change"""

    if money < 0:
        return 0
    if money == 0:
        return 1

    count = 0
    while(coins):
        count += change(money - coins[0], coins)
        coins = coins[1:]

    return count

if __name__ == '__main__':
    main()
