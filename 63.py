#!/usr/bin/env python

"""This script solves the Project Euler problem "Powerful digit counts". The
problem is: How many n-digit positive integers exist which are also an nth
power?
"""


def main():
    """Powerful digit counts"""

    count = 0
    n = 0
    match_seen = True
    while match_seen:
        n += 1
        match_seen = False
        num = 0
        power = 0
        while len(str(power)) <= n:
            num += 1
            power = pow(num, n)
            if len(str(power)) == n:
                count += 1
                match_seen = 1

    print(count)

if __name__ == '__main__':
    main()
