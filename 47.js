#!/usr/bin/env node

// Distinct primes factors

var program = require('commander');

program
    .version('0.1.0')
    .description('Distinct primes factors')
    .option('-t, --target <int>',
        'The target number of consecutive integers and distinct prime factors',
        Number, 4)
    .parse(process.argv);

var limit = 100;
var first;
while (typeof first == 'undefined') {
    limit *= 10;
    var sieve = [];
    var consecutive = 0;
    for (var i = 2; i <= limit; i++) {
        if (!sieve[i - 2]) {
            var j = 2 * i;
            while (j <= limit) {
                if (!sieve[j - 2]) {
                    sieve[j - 2] = 0;
                }
                sieve[j - 2]++;
                j += i;
            }
        }
        if (typeof sieve[i - 2] != 'undefined' &&
            sieve[i - 2] == program.target) {
            consecutive++;
            if (consecutive == program.target) {
                first = i - program.target + 1;
                break;
            }
        } else {
            consecutive = 0;
        }
    }
}

console.log(first);
