#!/usr/bin/env node

// Magic 5-gon ring

var program = require('commander');

program
    .version('0.1.0')
    .description('Magic 5-gon ring')
    .option('-r, --ring_size <int>',
        'The number of vertices in the magic ring', Number, 5)
    .option('-m, --max_digit <int>',
        'The number of digits to fill the rings with', Number, 10)
    .option('-t, --target_digits <int>',
        'The number of digits in the solution', Number, 16)
    .parse(process.argv);

var bigint = require('big-integer');
var combinatorics = require('js-combinatorics');
var sum = require('compute-sum');

// Group combinations by sum
var comb_by_sum = {};
var numbers = [];
for (var i = 1; i <= program.max_digit; i++) {
    numbers.push(i);
}
var combinations = combinatorics.combination(numbers, 3);
var combination;
while (combination = combinations.next()) {
    var comb_sum = sum(combination);
    if (!comb_by_sum[comb_sum]) {
        comb_by_sum[comb_sum] = [];
    }
    comb_by_sum[comb_sum].push(combination);
}

// Group combinations into rings with correct digits
var combs = [];
var sums = Object.keys(comb_by_sum);
for (var i = 0; i < sums.length; i++) {
    if (comb_by_sum[sums[i]].length < program.ring_size) {
        continue;
    }
    var combinations = combinatorics.combination(comb_by_sum[sums[i]],
        program.ring_size);
    var comb;
    while (comb = combinations.next()) {
        var digit_seen = {};
        for (var j = 0; j < comb.length; j++) {
            for (var k = 0; k < comb[j].length; k++) {
                if (!digit_seen[comb[j][k]]) {
                    digit_seen[comb[j][k]] = 0;
                }
                digit_seen[comb[j][k]]++;
            }
        }
        if (Object.keys(digit_seen).length != program.max_digit) {
            continue;
        }
        var max = 0;
        for (var digit in digit_seen) {
            if (digit_seen[digit] > max) {
                max = digit_seen[digit];
            }
        }
        if (max != 2) {
            continue;
        }

        // Reorder so first digit is the one that only appears once
        var ordered_comb = [];
        for (var j = 0; j < comb.length; j++) {
            ordered_comb.push(comb[j].sort(function(a, b) {
                return digit_seen[a] - digit_seen[b];
            }));
        }
        combs.push(ordered_comb);
    }
}

// Make all combinations of last two digits of each group
var new_combs = [];
for (var i = 0; i < combs.length; i++) {
    var group1 = combs[i][0];
    var group2 = [group1[0], group1[2], group1[1]];
    var digit_combs = [
        [group1],
        [group2]
    ];
    for (var n = 1; n < program.ring_size; n++) {
        group1 = combs[i][n];
        group2 = [group1[0], group1[2], group1[1]];
        var new_digit_combs = [];
        for (var j = 0; j < digit_combs.length; j++) {
            var digit_perm1 = clone(digit_combs[j]);
            var digit_perm2 = clone(digit_combs[j]);
            digit_perm1.push(group1);
            digit_perm2.push(group2);
            new_digit_combs.push(digit_perm1);
            new_digit_combs.push(digit_perm2);
        }
        digit_combs = new_digit_combs;
    }
    new_combs = new_combs.concat(digit_combs);
}
combs = new_combs;

// Get all permutations of each combination and filter invalid ones
var max_string = '';
for (var i = 0; i < program.target_digits; i++) {
    max_string += '0';
}
for (var i = 0; i < combs.length; i++) {
    var perms = combinatorics.permutation(combs[i]);
    var perm;
    while (perm = perms.next()) {
        var firsts = [];
        for (var j = 0; j < perm.length; j++) {
            firsts.push(perm[j][0]);
        }
        if (perm[0][0] != Math.min.apply(null, firsts)) {
            continue;
        }
        var string = '';
        for (var n = 0; n < program.ring_size; n++) {
            if (perm[n][2] != perm[(n + 1) % program.ring_size][1]) {
                break;
            }
            string += perm[n].join('');
        }
        if (string.length != program.target_digits) {
            continue;
        }
        if (string > max_string) {
            max_string = string;
        }
    }
}

console.log(max_string);

function clone(obj) {
    return JSON.parse(JSON.stringify(obj));
}
