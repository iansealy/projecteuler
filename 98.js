#!/usr/bin/env node

// Anagramic squares

var combinatorics = require('js-combinatorics');

var WORDS_URL = 'https://projecteuler.net/project/resources/p098_words.txt';

var request = require('request');
request(WORDS_URL, function(error, response, body) {
    if (!error && response.statusCode == 200) {
        find_square(body.replace(/"/g, "").split(","));
    }
});

function find_square(words) {
    // Get anagrams
    var anagram = {};
    for (var i = 0; i < words.length; i++) {
        var sorted_word = words[i].split('').sort().join('');
        if (!(sorted_word in anagram)) {
            anagram[sorted_word] = [];
        }
        anagram[sorted_word].push(words[i]);
    }
    var anagrams = [];
    var limit = 0;
    for (sorted_word in anagram) {
        if (anagram[sorted_word].length > 1) {
            anagrams.push(anagram[sorted_word]);
            if (sorted_word.length > limit) {
                limit = sorted_word.length;
            }
        }
    }

    // Get squares
    var all_squares = [];
    var n = 0;
    var n2 = 0;
    var len_n2 = 1;
    while (len_n2 <= limit) {
        n++;
        n2 = n * n;
        len_n2 = n2.toString().length;
        if (!all_squares[len_n2]) {
            all_squares[len_n2] = [];
        }
        all_squares[len_n2].push(n2.toString());
    }

    var max_square = 0;
    for (var i = 0; i < anagrams.length; i++) {
        var pairs = combinatorics.combination(anagrams[i], 2);
        var pair;
        while (pair = pairs.next()) {
            var squares = all_squares[pair[0].length];
            var is_square = {};
            for (var j = 0; j < squares.length; j++) {
                is_square[squares[j]] = true;
            }
            for (var j = 0; j < squares.length; j++) {
                var square = squares[j];
                var anagram1 = pair[0].split('');
                var digits1 = square.split('');
                var trans = {};
                for (var k = 0; k < anagram1.length; k++) {
                    trans[anagram1[k]] = digits1[k];
                }
                var digit = {};
                for (letter in trans) {
                    digit[trans[letter]] = true;
                }
                if (Object.keys(digit).length != Object.keys(trans).length) {
                    continue;
                }
                var anagram2 = pair[1].split('');
                var digits2 = [];
                for (var k = 0; k < anagram2.length; k++) {
                    digits2.push(trans[anagram2[k]]);
                }
                digits2 = digits2.join('');
                if (digits2 in is_square) {
                    if (parseInt(square) > max_square) {
                        max_square = parseInt(square);
                    }
                    if (parseInt(digits2) > max_square) {
                        max_square = parseInt(digits2);
                    }
                }
            }
        }
    }

    console.log(max_square);
}
