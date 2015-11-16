#!/usr/bin/env python

"""This script solves the Project Euler problem "Product-sum numbers". The
problem is: What is the sum of all the minimal product-sum numbers for
2<=k<=12000?
"""

from __future__ import division
import math
import argparse


def main(args):
    """Product-sum numbers"""

    factors_for = [[] for _ in range(2 * args.max + 1)]
    min_prod_sum = [None] * (args.max + 1)

    for n in range(2, 2 * args.max + 1):
        for low_factor in range(2, int(math.floor(math.sqrt(n))) + 1):
            if n % low_factor != 0:
                continue
            high_factor = n // low_factor
            factors_for[n].append([low_factor, high_factor])
            for factors in factors_for[high_factor]:
                if low_factor > factors[0]:
                    continue
                new_factors = [i for i in factors]
                new_factors.insert(0, low_factor)
                factors_for[n].append(new_factors)

    for n in range(2, 2 * args.max + 1):
        for factors in factors_for[n]:
            factor_sum = sum(factors)
            if factor_sum > n:
                continue
            k = n - factor_sum + len(factors)
            if k > args.max:
                continue
            if min_prod_sum[k] is None or min_prod_sum[k] > n:
                min_prod_sum[k] = n

    min_prod_sum = [i for i in min_prod_sum if i is not None]
    print(sum(set(min_prod_sum)))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Product-sum numbers')
    parser.add_argument(
        'max', metavar='MAX', type=int, default=12000, nargs='?',
        help='The maximum set size')
    args = parser.parse_args()

    main(args)
