#!/usr/bin/env python

"""This script solves the Project Euler problem "Number letter counts". The
problem is: If all the numbers from 1 to 1000 (one thousand) inclusive were
written out in words, how many letters would be used?
"""

import argparse
import re


def main(args):
    """Number letter counts"""

    sum = 0
    for num in range(args.limit):
        sum += len(get_in_words(num + 1))

    print(sum)


def get_in_words(num):
    """Convert integer to words (without spaces)"""

    unit_for = {
        1: 'one',
        2: 'two',
        3: 'three',
        4: 'four',
        5: 'five',
        6: 'six',
        7: 'seven',
        8: 'eight',
        9: 'nine',
    }
    teen_for = {
        11: 'eleven',
        12: 'twelve',
        13: 'thirteen',
        14: 'fourteen',
        15: 'fifteen',
        16: 'sixteen',
        17: 'seventeen',
        18: 'eighteen',
        19: 'nineteen',
    }
    tens_for = {
        1: 'ten',
        2: 'twenty',
        3: 'thirty',
        4: 'forty',
        5: 'fifty',
        6: 'sixty',
        7: 'seventy',
        8: 'eighty',
        9: 'ninety',
    }

    # 1000 is only possible 4 digit number
    if num == 1000:
        return 'onethousand'

    # Deal with 100s (don't require "and")
    match = re.search('^([1-9])00$', str(num))
    if match:
        return unit_for[int(match.group(1))] + 'hundred'

    words = ''

    # Deal with 100s part of 3 digit number and leave 1 or 2 digit number
    match = re.search('^([1-9])([0-9]{2})$', str(num))
    if match:
        words = words + unit_for[int(match.group(1))] + 'hundredand'
        num = int(match.group(2))

    # Numbers ending 01 to 09 (or just 1 to 9)
    if num < 10:
        return words + unit_for[num]

    # Numbers ending 10, 20 .. 80, 90
    match = re.search('^([1-9])0$', str(num))
    if match:
        return words + tens_for[int(match.group(1))]

    # Numbers ending 11 to 19
    if num < 20:
        return words + teen_for[num]

    # Remaining two digit numbers
    match = re.search('^([1-9])([1-9])$', str(num))
    if match:
        tens = tens_for[int(match.group(1))]
        units = unit_for[int(match.group(2))]
        return words + tens + units

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Number letter counts')
    parser.add_argument(
        'limit', metavar='LIMIT', type=int, default=1000, nargs='?',
        help='The highest number to convert')
    args = parser.parse_args()

    main(args)
