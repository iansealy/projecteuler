#!/usr/bin/env python

"""This script solves the Project Euler problem "Poker hands". The
problem is: How many hands does Player 1 win?
"""

from collections import Counter
try:
    from urllib.request import urlopen
except ImportError:
    from urllib import urlopen


def main():
    """Poker hands"""

    # Constants
    HANDS_URL = 'https://projecteuler.net/project/resources/p054_poker.txt'

    player1_wins = 0

    response = urlopen(HANDS_URL)
    for cards in response:
        cards = cards.decode('ascii').split()
        hand1 = cards[0:5]
        hand2 = cards[5:10]
        if score(hand1) > score(hand2):
            player1_wins += 1

    print(player1_wins)


def score(hand):
    """Get score for poker hand"""

    letter_to_hex = {'T': 'A', 'J': 'B', 'Q': 'C', 'K': 'D', 'A': 'E'}
    ranks = []
    suits = []
    for card in hand:
        rank = card[0:1]
        if rank in letter_to_hex:
            rank = letter_to_hex[rank]
        ranks.append(rank)
        suits.append(card[1:2])
    ranks = sorted(ranks)
    rank_count = Counter(ranks)
    suit_count = Counter(suits)

    flush = False
    if len(suit_count) == 1:
        flush = True

    straight = False
    if len(rank_count) == 5 and int(ranks[-1], 16) - int(ranks[0], 16) == 4:
        straight = True

    score = None
    if flush and straight:
        score = 9  # Straight flush
    elif 4 in rank_count.values():
        score = 8  # Four of a kind
    elif len(rank_count) == 2:
        score = 7  # Full house
    elif flush:
        score = 6  # Flush
    elif straight:
        score = 5  # Straight
    elif 3 in rank_count.values():
        score = 4  # Three of a kind
    elif len(rank_count) == 3:
        score = 3  # Two pair
    elif len(rank_count) == 4:
        score = 2  # One pair
    else:
        score = 1  # High card

    score = str(score)
    for rank, count in sorted(rank_count.items(), key=lambda x: (x[1], x[0]),
                              reverse=True):
        score = score + rank * count

    return score

if __name__ == '__main__':
    main()
