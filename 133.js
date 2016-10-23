#!/usr/bin/env node

// Repunit nonfactors

var program = require('commander');

program
    .version('0.1.0')
    .description('Repunit nonfactors')
    .option('-l, --limit <int>', 'The maximum prime', Number, 100000)
    .parse(process.argv);

var primes = get_primes_up_to(program.limit);
var is_prime = {};
for (var i = 0; i < primes.length; i++) {
    is_prime[primes[i]] = true;
}
for (var n = 1; n <= 16; n++) {
    for (var i = 0; i < primes.length; i++) {
        if (modular_exponentiation(10, Math.pow(10, n), 9 * primes[i]) == 1) {
            delete is_prime[primes[i]];
        }
    }
}

var sum = 0;
for (prime in is_prime) {
    sum += parseInt(prime);
}

console.log(sum);

function modular_exponentiation(base, exp, mod) {
    var result = 1;

    base = base % mod;
    while (exp > 0) {
        if (exp % 2 == 1) {
            result = (result * base) % mod;
        }
        exp = Math.floor(exp / 2);
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
