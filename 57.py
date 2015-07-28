#!/usr/bin/env python

"""This script solves the Project Euler problem "Square root convergents". The
problem is: In the first one-thousand expansions, how many fractions contain a
numerator with more digits than denominator?
"""


def main():
    """Square root convergents"""

    # Constants
    LIMIT = 1000

    num_fractions = 0

    denom_prev1 = [5]
    denom_prev2 = [2]
    for _ in range(2, LIMIT):
        denom = []
        numer = []
        carry_denom = 0
        carry_numer = 0
        for digit in denom_prev1:
            prev2_digit = 0
            if denom_prev2:
                prev2_digit = denom_prev2.pop(0)
            sum_denom = 2 * digit + prev2_digit + carry_denom
            sum_numer = 3 * digit + prev2_digit + carry_numer
            denom.append(int(str(sum_denom)[-1]))
            numer.append(int(str(sum_numer)[-1]))
            carry_denom = 0
            carry_numer = 0
            if sum_denom >= 10:
                carry_denom = int(str(sum_denom)[:-1])
            if sum_numer >= 10:
                carry_numer = int(str(sum_numer)[:-1])

        if carry_denom:
            denom.extend([int(i) for i in reversed(str(carry_denom))])
        if carry_numer:
            numer.extend([int(i) for i in reversed(str(carry_numer))])
        if len(numer) > len(denom):
            num_fractions += 1
        denom_prev2 = denom_prev1
        denom_prev1 = denom

    print(num_fractions)

if __name__ == '__main__':
    main()
