#!/usr/bin/env node

// Poker hands

var HANDS_URL = 'https://projecteuler.net/project/resources/p054_poker.txt';

var request = require('request');
request(HANDS_URL, function(error, response, body) {
    if (!error && response.statusCode == 200) {
        count_wins(body.trim().split(/[\r\n]+/));
    }
});

function count_wins(hands) {
    var player1_wins = 0;
    for (var i = 0; i < hands.length; i++) {
        var cards = hands[i].split(" ");
        var hand1 = cards.slice(0, 5);
        var hand2 = cards.slice(5);
        if (score(hand1) > score(hand2)) {
            player1_wins++;
        }
    }
    console.log(player1_wins);
}

function score(hand) {
    var letter_to_hex = {
        'T': 'A',
        'J': 'B',
        'Q': 'C',
        'K': 'D',
        'A': 'E'
    }
    var ranks = [];
    var suits = [];
    var rank_count = {};
    var suit_count = {};
    for (var i = 0; i < hand.length; i++) {
        var rank = hand[i].substring(0, 1);
        if (letter_to_hex[rank]) {
            rank = letter_to_hex[rank];
        }
        ranks.push(rank);
        if (!rank_count[rank]) {
            rank_count[rank] = 0;
        }
        rank_count[rank]++;
        var suit = hand[i].substring(1);
        suits.push(suit);
        if (!suit_count[suit]) {
            suit_count[suit] = 0;
        }
        suit_count[suit]++;
    }
    ranks.sort();
    var rank_counts = Object.keys(rank_count).map(function(rank) {
        return rank_count[rank];
    });
    rank_counts.sort();

    var flush = false;
    if (Object.keys(suit_count).length == 1) {
        flush = true;
    }

    var straight = false;
    if (Object.keys(rank_count).length == 5 &&
        parseInt(ranks[4], 16) - parseInt(ranks[0], 16) == 4) {
        straight = true;
    }

    var score;
    if (flush && straight) {
        score = 9; // Straight flush
    } else if (rank_counts[1] == 4) {
        score = 8; // Four of a kind
    } else if (rank_counts.length == 2) {
        score = 7; // Full house
    } else if (flush) {
        score = 6; // Flush
    } else if (straight) {
        score = 5; // Straight
    } else if (rank_counts[2] == 3) {
        score = 4; // Three of a kind
    } else if (rank_counts.length == 3) {
        score = 3; // Two pair
    } else if (rank_counts.length == 4) {
        score = 2; // One pair
    } else {
        score = 1; // High card
    }
    score = score.toString();

    ranks = Object.keys(rank_count);
    ranks.sort(function(a, b) {
        if (rank_count[a] > rank_count[b]) {
            return -1;
        } else if (rank_count[a] < rank_count[b]) {
            return 1;
        } else if (a > b) {
            return -1;
        } else if (a < b) {
            return 1;
        } else {
            return 1;
        }
    });
    for (var i = 0; i < ranks.length; i++) {
        for (var j = 0; j < rank_count[ranks[i]]; j++) {
            score += ranks[i];
        }
    }

    return score;
}
