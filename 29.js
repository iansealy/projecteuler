#!/usr/bin/env node

// Distinct powers

var program = require('commander');

program
    .version('0.1.0')
    .description('Distinct powers')
    .option('-m, --max <int>', 'The maximum value of a and b', Number, 100)
    .parse(process.argv);

var primes = get_primes_up_to(program.max);

var term = {};

for (var a = 2; a <= program.max; a++) {
    var a_factors = get_prime_factors(a, primes);
    for (var b = 2; b <= program.max; b++) {
        factors = [];
        for (var i = 0; i < a_factors.length; i++) {
            for (var j = 0; j < b; j++) {
                factors.push(a_factors[i]);
            }
        }
        term[factors.join('*')] = true;
    }
}

console.log(Object.keys(term).length);

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

function get_prime_factors(number, primes) {
    factors = [];

    for (var i = 0; i < primes.length; i++) {
        while (number % primes[i] == 0) {
            factors.push(primes[i]);
            number /= primes[i];
        }
    }

    return factors;
}
