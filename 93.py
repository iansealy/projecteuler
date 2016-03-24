#!/usr/bin/env python

"""This script solves the Project Euler problem "Arithmetic expressions". The
problem is: Find the set of four distinct digits, a < b < c < d, for which the
longest set of consecutive positive integers, 1 to n, can be obtained, giving
your answer as a string: abcd.
"""

from __future__ import division
import argparse
from itertools import product, combinations, permutations


def main(args):
    """Arithmetic expressions"""

    operators = [
        lambda n1, n2: n1 + n2,
        lambda n1, n2: n1 - n2,
        lambda n1, n2: n1 * n2,
        lambda n1, n2: 0 if not n2 else n1 / n2
    ]

    op_perms = list(product(range(4), repeat=3))
    order_perms = list(permutations(range(1, 4)))

    max_digits = None
    max_consec = 0
    for digit_comb in combinations(range(1, args.max_digit + 1), 4):
        seen = [False] * (pow(9, 4) + 1)
        for digit_perm in permutations(digit_comb):
            for op_perm in op_perms:
                for order_perm in order_perms:
                    nums = list(digit_perm)
                    ops = list(op_perm)
                    order = list(order_perm)
                    while order:
                        ordinal = order.pop(0)
                        num1 = nums[ordinal-1:ordinal][0]
                        num2 = nums[ordinal:ordinal+1][0]
                        op = ops[ordinal-1:ordinal][0]
                        nums[ordinal-1:ordinal+1] = [operators[op](num1, num2)]
                        ops[ordinal-1:ordinal] = []
                        order = [i - 1 if i > ordinal else i for i in order]
                    num = nums[0]
                    if int(num) != num or num < 1:
                        continue
                    seen[int(num)] = True
        consec = 0
        while seen[consec + 1]:
            consec += 1
        if consec > max_consec:
            max_consec = consec
            max_digits = ''.join(str(i) for i in sorted(digit_comb))

    print(max_digits)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Arithmetic expressions')
    parser.add_argument(
        'max_digit', metavar='MAX_DIGIT', type=int, default=9, nargs='?',
        help='The highest digit')
    args = parser.parse_args()

    main(args)
