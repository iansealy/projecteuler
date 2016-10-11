#!/usr/bin/env node

// Composites with prime repunit property

var program = require('commander');

program
    .version('0.1.0')
    .description('Composites with prime repunit property')
    .option('-l, --limit <int>',
        'The number of composite values to sum', Number, 25)
    .parse(process.argv);

var sum = require('compute-sum');

var composite = [];
var n = 90;
while (composite.length < program.limit) {
    n++;
    if (n % 2 == 0 || n % 5 == 0 || is_prime(n)) {
        continue;
    }
    var rkmodn = 1;
    var k = 1;
    while (rkmodn % n != 0) {
        k++;
        rkmodn = (rkmodn * 10 + 1) % n;
    }
    if ((n - 1) % k != 0) {
        continue;
    }
    composite.push(n);
}

console.log(sum(composite));

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
