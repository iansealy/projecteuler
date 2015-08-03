#!/usr/bin/env python

"""This script solves the Project Euler problem "XOR decryption". The problem
is: Using cipher.txt, a file containing the encrypted ASCII codes, and the
knowledge that the plain text must contain common English words, decrypt the
message and find the sum of the ASCII values in the original text.
"""

import csv
from itertools import product
try:
    from urllib.request import urlopen
except ImportError:
    from urllib import urlopen
try:
    from io import StringIO
except ImportError:
    from StringIO import StringIO


def main():
    """XOR decryption"""

    # Constants
    CIPHER_URL = 'https://projecteuler.net/project/resources/p059_cipher.txt'

    plain_sum = 0

    response = urlopen(CIPHER_URL)
    cipher = response.read()
    cipher = [row for row in csv.reader(StringIO(cipher.decode('utf-8')))][0]

    for key in product(range(97, 123), repeat=3):
        plain = ''
        plain_sum = 0
        for i, ascii in enumerate(cipher):
            xor = int(ascii) ^ key[i % 3]
            plain += chr(xor)
            plain_sum += xor
        if plain.find(' the ') >= 0:
            break

    print(plain_sum)

if __name__ == '__main__':
    main()
