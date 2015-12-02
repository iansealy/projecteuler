#!/usr/bin/env node

// 10001st prime

var program = require('commander');

program
    .version('0.1.0')
    .description('10001st prime')
    .option('-o, --ordinal <int>',
        'The ordinal of the required prime', Number, 10001)
    .parse(process.argv);

var candidate = 1;
var primes_got = 1; // 2 is a prime

while (primes_got < program.ordinal) {
    candidate += 2;
    if (is_prime(candidate)) {
        primes_got++;
    }
}

console.log(candidate);

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
