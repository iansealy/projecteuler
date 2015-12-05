#!/usr/bin/env node

// Summation of primes

var program = require('commander');

program
    .version('0.1.0')
    .description('Summation of primes')
    .option('-l, --limit <int>',
        'The number below which to sum up all primes', Number, 2000000)
    .parse(process.argv);

var sieve_bound = Math.floor((program.limit - 1) / 2);
var sieve = [];
var cross_limit = Math.floor((Math.sqrt(program.limit) - 1) / 2);

var i = 1;
while (i <= cross_limit) {
    if (!sieve[i - 1]) {
        // 2 * i + 1 is prime, so mark multiples
        var j = 2 * i * (i + 1);
        while (j <= sieve_bound) {
            sieve[j - 1] = true;
            j += 2 * i + 1;
        }
    }
    i++;
}

var sum = 2 // 2 is a prime
i = 1;
while (i <= sieve_bound) {
    if (!sieve[i - 1]) {
        sum += 2 * i + 1;
    }
    i++;
}

console.log(sum);
