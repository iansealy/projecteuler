#!/usr/bin/env node

// Lexicographic permutations

var program = require('commander');

program
    .version('0.1.0')
    .description('Lexicographic permutations')
    .option('-d, --digits <int>', 'The number of digits to permute',
        Number, 10)
    .option('-o, --ordinal <int>', 'The permutation of interest',
        Number, 1000000)
    .parse(process.argv);

var permutation = '';
var in_permutation = [];
var running_total = 0;
for (var digits_left = program.digits; digits_left >= 0; digits_left--) {
    var num_in_batch = factorial(digits_left) / digits_left;
    for (var digit = 0; digit < program.digits; digit++) {
        if (in_permutation[digit]) {
            continue;
        }
        if (running_total + num_in_batch >= program.ordinal) {
            permutation += digit.toString();
            in_permutation[digit] = true;
            break;
        } else {
            running_total += num_in_batch;
        }
    }
}

console.log(permutation);

function factorial(number) {
    var factorial = 1;

    while (number > 1) {
        factorial *= number;
        number--;
    }

    return factorial;
}
