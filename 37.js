#!/usr/bin/env node

// Truncatable primes

var TARGET_TRUNCATABLE = 11;

var max_prime = 1;
var truncatable = [];
var sum = 0;

while (truncatable.length < TARGET_TRUNCATABLE) {
    max_prime *= 10;
    truncatable = [];
    sum = 0;

    primes = get_primes_up_to(max_prime);
    is_prime = {};
    for (var i = 0; i < primes.length; i++) {
        is_prime[primes[i].toString()] = true;
    }
    for (var i = 0; i < primes.length; i++) {
        if (is_truncatable(primes[i], is_prime)) {
            truncatable.push(primes[i]);
            sum += primes[i];
        }
    }
}

console.log(sum);

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

function is_truncatable(prime, is_prime) {
    if (prime < 10) {
        return false;
    }

    prime = prime.toString();

    for (var i = 1; i < prime.length; i++) {
        if (!is_prime[prime.substr(i)] || !is_prime[prime.substr(0, i)]) {
            return false;
        }
    }

    return true;
}
