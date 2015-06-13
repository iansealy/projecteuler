#!/usr/bin/env python

"""This script solves the Project Euler problem "Sub-string divisibility". The
problem is: Find the sum of all 0 to 9 pandigital numbers with this property.
"""


def main():
    """Sub-string divisibility"""

    multiples = get_divisible_by(2)
    pandigitals = [str(first) + i for i in multiples for first in range(10)]
    pandigitals = filter_not_pandigital(pandigitals)
    for prime in (3, 5, 7, 11, 13, 17):
        multiples = get_divisible_by(prime)
        next_char_for = {}
        for multiple in multiples:
            prefix = multiple[0:2]
            if prefix not in next_char_for:
                next_char_for[prefix] = []
            next_char_for[prefix].append(multiple[2:3])
        new_pandigitals = []
        for pandigital in pandigitals:
            suffix = pandigital[-2:]
            if suffix in next_char_for:
                for next_char in next_char_for[suffix]:
                    new_pandigitals.append(pandigital + next_char)
        pandigitals = filter_not_pandigital(new_pandigitals)

    print(sum(int(i) for i in pandigitals))


def get_divisible_by(divisor):
    numbers = []
    number = 0
    while number + divisor < 1000:
        number += divisor
        str_number = '{:03d}'.format(number)
        digits = set(i for i in str_number)
        if len(digits) == len(str_number):
            numbers.append(str_number)

    return(numbers)


def filter_not_pandigital(candidates):
    filtered = []

    for candidate in candidates:
        digits = set(i for i in candidate)
        if len(digits) == len(candidate):
            filtered.append(candidate)

    return(filtered)

if __name__ == '__main__':
    main()
