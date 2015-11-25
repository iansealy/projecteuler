#!/usr/bin/env node

// 10001st prime

var program = require('commander');

program
    .version('0.1.0')
    .description('10001st prime')
    .option('-o, --ordinal <int>',
        'The ordinal of the required prime', Number, 10001)
    .parse(process.argv);

var primes = [2, 3];
var num = 5;

while (primes.length < program.ordinal) {
    var is_prime = true;
    var num_sqrt = Math.floor(Math.sqrt(num));
    for (var i = 0; i < primes.length; i++) {
        if (primes[i] > num_sqrt) {
            break;
        }
        if (num % primes[i] == 0) {
            is_prime = false;
            break;
        }
    }
    if (is_prime) {
        primes.push(num);
    }
    num += 2;
}

console.log(primes.pop());
