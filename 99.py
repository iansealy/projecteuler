#!/usr/bin/env python

"""This script solves the Project Euler problem "Largest exponential". The
problem is: Using base_exp.txt, a 22K text file containing one thousand lines
with a base/exponent pair on each line, determine which line number has the
greatest numerical value.
"""

try:
    from urllib.request import urlopen
except ImportError:
    from urllib import urlopen
import math


def main():
    """Largest exponential"""

    # Constants
    EXP_URL = 'https://projecteuler.net/project/resources/p099_base_exp.txt'

    max_num = 0
    max_line = 0
    for line, pair in enumerate(urlopen(EXP_URL)):
        base, exp = pair.rstrip().decode('ascii').split(',')
        num = int(exp) * math.log(int(base))
        if num > max_num:
            max_num = num
            max_line = line + 1

    print(max_line)

if __name__ == '__main__':
    main()
