#!/usr/bin/env python

"""This script solves the Project Euler problem "Square digit chains". The
problem is: How many starting numbers below ten million will arrive at 89?
"""


def main():
    """Square digit chains"""

    # Constants
    MAX = 10000000

    count = 0

    cache = {
        '1': 1,
        '89': 89,
    }

    for num in range(2, MAX):
        chain = []
        final = None
        n = ''.join(sorted(digit for digit in str(num)))
        while (True):
            if n in cache:
                final = cache[n]
                break
            chain.append(n)
            n = str(sum(int(digit) * int(digit) for digit in str(n)))
        if final == 89:
            count += 1
        for n in chain:
            cache[n] = final

    print(count)

if __name__ == '__main__':
    main()
