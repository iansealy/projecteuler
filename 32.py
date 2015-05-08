#!/usr/bin/env python

"""This script solves the Project Euler problem "Pandigital products". The
problem is: Find the sum of all products whose multiplicand/multiplier/product
identity can be written as a 1 through 9 pandigital.
"""


def main():
    """Pandigital products"""

    # Can only get 9 pandigital number via x * xxxx = xxxx or xx * xxx = xxxx

    products = set()
    products.update(get_products(1, 9, 1234, 9876))
    products.update(get_products(12, 98, 123, 987))

    print(sum(products))


def get_products(low_multiplicand, high_multiplicand, low_multiplier,
                 high_multiplier):
    products = set()

    for multiplicand in range(low_multiplicand, high_multiplicand + 1):
        if '0' in str(multiplicand):
            continue
        for multiplier in range(low_multiplier, high_multiplier + 1):
            if '0' in str(multiplier):
                continue
            product = multiplicand * multiplier
            if product >= 10000 or '0' in str(product):
                continue
            digits = set(i for i in str(multiplicand) + str(multiplier)
                         + str(product))
            if len(digits) == 9:
                products.add(product)

    return(products)

if __name__ == '__main__':
    main()
