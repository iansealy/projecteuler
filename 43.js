#!/usr/bin/env node

// Sub-string divisibility

var pandigital = [];
var multiples = get_divisible_by(2);
for (var first = 0; first < 10; first++) {
    for (var i = 0; i < multiples.length; i++) {
        pandigital.push(first.toString() + multiples[i]);
    }
}
pandigital = filter_not_pandigital(pandigital);
var primes = [3, 5, 7, 11, 13, 17];
for (var i = 0; i < primes.length; i++) {
    multiples = get_divisible_by(primes[i]);
    var next_char_for = {};
    for (var j = 0; j < multiples.length; j++) {
        var prefix = multiples[j].substr(0, 2);
        if (!next_char_for[prefix]) {
            next_char_for[prefix] = [];
        }
        next_char_for[prefix].push(multiples[j].slice(-1));
    }
    var new_pandigital = [];
    for (var j = 0; j < pandigital.length; j++) {
        var suffix = pandigital[j].slice(-2);
        if (next_char_for[suffix]) {
            for (var k = 0; k < next_char_for[suffix].length; k++) {
                new_pandigital.push(pandigital[j] + next_char_for[suffix][k]);
            }
        }
    }
    pandigital = filter_not_pandigital(new_pandigital);
}

var sum = 0;
for (var i = 0; i < pandigital.length; i++) {
    sum += parseInt(pandigital[i]);
}

console.log(sum);

// Get 3 digit numbers divisible by a specified number
function get_divisible_by(divisor) {
    var numbers = [];
    var number = 0;
    while (number + divisor < 1000) {
        number += divisor;
        str_number = ('000' + number).slice(-3);
        var digits = unique(str_number.split(''));
        if (digits.length != str_number.length) {
            continue;
        }
        numbers.push(str_number);
    }

    return numbers;
}

// Filter out non-pandigital numbers
function filter_not_pandigital(candidates) {
    filtered = [];
    for (var i = 0; i < candidates.length; i++) {
        var digits = unique(candidates[i].split(''));
        if (digits.length != candidates[i].length) {
            continue;
        }
        filtered.push(candidates[i]);
    }

    return filtered;
}

function unique(array) {
    return array.reduce(function(prev, cur) {
        if (prev.indexOf(cur) < 0) {
            prev.push(cur);
        }
        return prev;
    }, []);
}
