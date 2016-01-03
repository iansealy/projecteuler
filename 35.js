#!/usr/bin/env node

// Circular primes

var program = require('commander');

program
    .version('0.1.0')
    .description('Circular primes')
    .option('-m, --max <int>', 'The maximum to check for circular primes',
        Number, 1000000)
    .parse(process.argv);

var primes = get_primes_up_to(program.max - 1);
is_prime = {};
for (var i = 0; i < primes.length; i++) {
    is_prime[primes[i]] = true;
}

var circular = [];
for (var i = 0; i < primes.length; i++) {
    is_circular = true;
    var prime = primes[i].toString();
    for (var j = 0; j < prime.length; j++) {
        prime = prime.substring(1) + prime.substring(0, 1);
        if (!is_prime[prime]) {
            is_circular = false;
        }
    }
    if (is_circular) {
        circular.push(prime);
    }
}

console.log(circular.length);

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
