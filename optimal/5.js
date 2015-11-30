#!/usr/bin/env node

// Smallest multiple

var program = require('commander');

program
    .version('0.1.0')
    .description('Smallest multiple')
    .option('-n, --max_num <int>',
        'The number ending the sequence to find the smallest multiple of',
        Number, 20)
    .parse(process.argv);

var multiple = 1;
var primes = get_primes(program.max_num);
var power_limit = Math.floor(Math.sqrt(program.max_num));

for (var i = 0; i < primes.length; i++) {
    var power = 1;
    if (primes[i] < power_limit) {
        power = Math.floor(Math.log(program.max_num) / Math.log(primes[i]));
    }
    multiple *= Math.pow(primes[i], power);
}

console.log(multiple);

function get_primes(limit) {
    var primes = [2, 3];
    var num = 5;

    while (num <= limit) {
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

    return primes;
}
