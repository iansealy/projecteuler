#!/usr/bin/env node

// Prime cube partnership

var program = require('commander');

program
    .version('0.1.0')
    .description('Prime cube partnership')
    .option('-l, --limit <int>', 'The maximum prime', Number, 1000000)
    .parse(process.argv);

var count = 0;

var n = 1;
while (true) {
    n++;
    var diff = n * n * n - (n - 1) * (n - 1) * (n - 1);
    if (diff > program.limit) {
        break;
    }
    if (is_prime(diff)) {
        count++;
    }
}

console.log(count);

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
