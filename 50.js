#!/usr/bin/env node

// Consecutive prime sum

var program = require('commander');

program
    .version('0.1.0')
    .description('Consecutive prime sum')
    .option('-l, --limit <int>',
        'The limit on the highest prime', Number, 1000000)
    .parse(process.argv);

primes = get_primes_up_to(program.limit);
is_prime = {};
for (var i = 0; i < primes.length; i++) {
    is_prime[primes[i]] = true;
}

var max_consecutive = 0;
var max_prime;
while (primes.length) {
    var total = 0;
    for (var i = 1; i <= primes.length; i++) {
        total += primes[i - 1];
        if (total > program.limit) {
            break;
        }
        if (is_prime[total] && i > max_consecutive) {
            max_consecutive = i;
            max_prime = total;
        }
    }
    primes.shift();
}

console.log(max_prime);

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
