#!/usr/bin/env node

// Quadratic primes

var MAX_A = 999;
var MAX_B = 999;
var PRIMES_LIMIT = 1000000;

primes = get_primes_up_to(PRIMES_LIMIT);
is_prime = {};
for (var i = 0; i < primes.length; i++) {
    is_prime[primes[i]] = true;
}

var max_n = 0;
var max_product;

for (var a = -MAX_A; a <= MAX_A; a++) {
    for (var b = -MAX_B; b <= MAX_B; b++) {
        var n = 0;
        while (true) {
            var quadratic = n * n + a * n + b;
            if (!is_prime[quadratic]) {
                break;
            }
            n++;
        }
        if (n > max_n) {
            max_n = n;
            max_product = a * b;
        }
    }
}

console.log(max_product);

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
