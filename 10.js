#!/usr/bin/env node

// Summation of primes

var program = require('commander');

program
    .version('0.1.0')
    .description('Summation of primes')
    .option('-l, --limit <int>',
        'The number below which to sum up all primes', Number, 2000000)
    .parse(process.argv);

var candidate = 3;
var sum = 2;

while (candidate < program.limit) {
    if (is_prime(candidate)) {
        sum += candidate;
    }
    candidate += 2;
}

console.log(sum);

function is_prime(num) {
    if (num == 1) {
        return false; // 1 isn't prime
    } else if (num < 4) {
        return true; // 2 and 3 are prime
    } else if (num % 2 == 0) {
        return false; // Even numbers aren't prime
    } else if (num < 9) {
        return true; // 5 and 7 are prime
    } else if (num % 3 == 0) {
        return false; // Numbers divisible by three aren't prime
    }

    var num_sqrt = Math.floor(Math.sqrt(num));
    var factor = 5;
    while (factor <= num_sqrt) {
        if (num % factor == 0) {
            return false; // Primes greater than 3 are 6k - 1
        } else if (num % (factor + 2) == 0) {
            return false; // Or 6k + 1
        }
        factor += 6;
    }

    return true;
}
