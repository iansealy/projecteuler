#!/usr/bin/env python

"""This script solves the Project Euler problem "Anagramic squares". The
problem is: What is the largest square number formed by any member of such a
pair?
"""

import csv
try:
    from urllib.request import urlopen
except ImportError:
    from urllib import urlopen
try:
    from io import StringIO
except ImportError:
    from StringIO import StringIO
from collections import defaultdict
from itertools import combinations


def main():
    """Anagramic squares"""

    # Constants
    WORDS_URL = 'https://projecteuler.net/project/resources/p098_words.txt'

    response = urlopen(WORDS_URL)
    words = response.read()
    words = [row for row in csv.reader(StringIO(words.decode('utf-8')))][0]

    # Get anagrams
    anagram = defaultdict(set)
    sorted_words = [''.join(sorted(word)) for word in words]
    for key, word in sorted(zip(sorted_words, words)):
        anagram[key].add(word)
    anagrams = [anagram_set for anagram_set in anagram.values()
                if len(anagram_set) > 1]

    # Get all squares
    all_squares = defaultdict(list)
    n = 0
    n2 = 0
    len_n2 = 1
    limit = max(len(word) for word in words)
    while len_n2 <= limit:
        n += 1
        n2 = n * n
        len_n2 = len(str(n2))
        all_squares[len_n2].append(n2)

    max_square = 0
    for anagram_set in anagrams:
        # Get all pairs of anagrams
        for pair in combinations(anagram_set, 2):
            squares = all_squares[len(str(pair[0]))]
            for square in squares:
                translation = dict(zip(list(pair[0]), list(str(square))))
                if len(set(translation.values())) != len(translation):
                    continue
                tr_anagram = int(''.join(translation[letter]
                                         for letter in pair[1]))
                if tr_anagram in squares:
                    if square > max_square:
                        max_square = square
                    if tr_anagram > max_square:
                        max_square = tr_anagram
    print(max_square)

if __name__ == '__main__':
    main()
