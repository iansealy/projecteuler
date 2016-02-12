#!/usr/bin/env node

// Counting fractions

var program = require('commander');

program
    .version('0.1.0')
    .description('Counting fractions')
    .option('-l, --limit <int>', 'The limit on d', Number, 1000000)
    .parse(process.argv);

var sum = require('compute-sum');

var sieve = [];
for (var i = 0; i <= program.limit; i++) {
    sieve.push(i);
}
for (var i = 2; i <= program.limit; i++) {
    if (sieve[i] == i) {
        var multiple = i;
        while (multiple <= program.limit) {
            sieve[multiple] *= (1 - 1 / i);
            multiple += i;
        }
    }
}

console.log(sum(sieve) - 1);
