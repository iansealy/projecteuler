#!/usr/bin/env node

// Amicable numbers

var program = require('commander');

program
    .version('0.1.0')
    .description('Amicable numbers')
    .option('-l, --limit <int>', 'The maximum amicable number', Number, 10000)
    .parse(process.argv);

var proper_divisor_sums = [0];
for (var i = 1; i < program.limit; i++) {
    proper_divisor_sums.push(sum_proper_divisors(i));
}

var sum = 0;

for (var i = 2; i < program.limit; i++) {
    if (proper_divisor_sums[i] >= program.limit) {
        continue;
    }
    if (proper_divisor_sums[i] == i) {
        continue;
    }
    if (proper_divisor_sums[proper_divisor_sums[i]] == i) {
        sum += i;
    }
}

console.log(sum);

function sum_proper_divisors(number) {
    var proper_divisor_sum = 1;

    var limit = Math.floor(Math.sqrt(number));
    for (var i = 2; i <= limit; i++) {
        if (number % i == 0) {
            proper_divisor_sum += i + number / i;
        }
    }

    return proper_divisor_sum;
}
