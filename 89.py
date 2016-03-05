#!/usr/bin/env python

"""This script solves the Project Euler problem "Roman numerals". The problem
is: Find the number of characters saved by writing each of these in their
minimal form.
"""

from __future__ import division
try:
    from urllib.request import urlopen
except ImportError:
    from urllib import urlopen
import re


def main():
    """Roman numerals"""

    # Constants
    URL = 'https://projecteuler.net/project/resources/p089_roman.txt'
    global TO_DECIMAL
    TO_DECIMAL = {
        'I': 1,
        'V': 5,
        'X': 10,
        'L': 50,
        'C': 100,
        'D': 500,
        'M': 1000,
    }
    global TO_ROMAN
    TO_ROMAN = [
        [1000, 'M'],
        [900, 'CM'],
        [500, 'D'],
        [400, 'CD'],
        [100, 'C'],
        [90, 'XC'],
        [50, 'L'],
        [40, 'XL'],
        [10, 'X'],
        [9, 'IX'],
        [5, 'V'],
        [4, 'IV'],
        [1, 'I'],
    ]

    # Prepare numbers
    non_minimal_nums = [line.rstrip().decode('ascii') for line in urlopen(URL)]

    minimal_length = 0
    non_minimal_length = 0
    for num in non_minimal_nums:
        non_minimal_length += len(str(num))
        minimal_num = to_roman(to_decimal(num))
        minimal_length += len(str(minimal_num))

    print(non_minimal_length - minimal_length)


def to_decimal(roman):
    decimal = 0

    while(roman):
        match = re.search('^(IV|IX|XL|XC|CD|CM)', roman)
        if match:
            comb = match.group(1)
            decimal += TO_DECIMAL[comb[1]] - TO_DECIMAL[comb[0]]
            roman = roman[2:]
        else:
            decimal += TO_DECIMAL[roman[0]]
            roman = roman[1:]

    return(decimal)


def to_roman(decimal):
    roman = ''

    for pair in TO_ROMAN:
        quotient = decimal // pair[0]
        roman += pair[1] * quotient
        decimal = decimal % pair[0]

    return(roman)

if __name__ == '__main__':
    main()
