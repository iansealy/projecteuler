#!/usr/bin/env node

// Highly divisible triangular number

var program = require('commander');

program
    .version('0.1.0')
    .description('Highly divisible triangular number')
    .option('-d, --divisors <int>',
        'The minimum number of divisors the triangle number should have',
        Number, 500)
    .parse(process.argv);

var ordinal = 1;
var triangle_number = 1;
var num_factors = 1;

while (num_factors <= program.divisors) {
    ordinal++;
    triangle_number += ordinal;
    num_factors = get_factors(triangle_number).length;
}

console.log(triangle_number);

function get_factors(number) {
    var factors = [1, number];

    var limit = Math.floor(Math.sqrt(number));
    for (var i = 2; i <= limit; i++) {
        if (number % i == 0) {
            factors.push(i, number / i);
        }
    }

    return factors;
}
