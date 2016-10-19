#!/usr/bin/env node

// Large repunit factors

var program = require('commander');

program
    .version('0.1.0')
    .description('Large repunit factors')
    .option('-k, --k <int>', 'The number of digits in the repunit',
        Number, Math.pow(10, 9))
    .option('-f, --factors <int>', 'The number of prime factors to sum',
        Number, 40)
    .parse(process.argv);

var sum = require('compute-sum');

var limit = 1000;
var factors = [];
while (factors.length < program.factors) {
    factors = [];
    limit *= 10;
    var primes = get_primes_up_to(limit);
    for (var i = 0; i < primes.length; i++) {
        if (modular_exponentiation(10, program.k, 9 * primes[i]) == 1) {
            factors.push(primes[i]);
            if (factors.length == program.factors) {
                break;
            }
        }
    }
}

console.log(sum(factors));

function modular_exponentiation(base, exp, mod) {
    var result = 1;

    base = base % mod;
    while (exp > 0) {
        if (exp % 2 == 1) {
            result = (result * base) % mod;
        }
        exp = exp >> 1;
        base = (base * base) % mod;
    }

    return result;
}

function get_primes_up_to(limit) {
    var sieve_bound = Math.floor((limit - 1) / 2); // Last index of sieve
    var sieve = [];
    var cross_limit = Math.floor((Math.floor(Math.sqrt(limit)) - 1) / 2);
    for (var i = 1; i <= cross_limit; i++) {
        if (!sieve[i - 1]) {
            // 2 * i + 1 is prime, so mark multiples
            var j = 2 * i * (i + 1);
            while (j <= sieve_bound) {
                sieve[j - 1] = true;
                j += 2 * i + 1;
            }
        }
    }

    var primes = [2];
    for (var i = 1; i <= sieve_bound; i++) {
        if (!sieve[i - 1]) {
            primes.push(2 * i + 1);
        }
    }

    return primes;
}
