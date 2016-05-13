#!/usr/bin/env python

"""This script solves the Project Euler problem "Optimum polynomial". The
problem is: Find the sum of FITs for the BOPs.
"""


def main():
    """Optimum polynomial"""

    # Constants
    MAX_N = 11

    seq = [polynomial(n) for n in range(1, MAX_N + 1)]

    fits_sum = 0
    for k in range(1, MAX_N):
        potential_fit = 0
        for i in range(1, k + 1):
            numer = 1
            denom = 1
            for j in range(1, k + 1):
                if i == j:
                    continue
                numer *= (k + 1 - j)
                denom *= (i - j)
            potential_fit += seq[i - 1] * numer / denom
        if potential_fit != seq[k]:
            fits_sum += potential_fit

    print(fits_sum)


def polynomial(n):
    return (1 - n + n**2 - n**3 + n**4 - n**5 +
            n**6 - n**7 + n**8 - n**9 + n**10)

if __name__ == '__main__':
    main()
