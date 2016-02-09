#!/usr/bin/env node

// Totient permutation

var LIMIT = 1e7;

var min_ratio;
var n_for_min_ratio;

var primes = get_primes_up_to(2 * Math.sqrt(LIMIT));

for (var i = 0; i < primes.length; i++) {
    for (var j = i; j < primes.length; j++) {
        var n = primes[i] * primes[j];
        if (n >= LIMIT) {
            continue;
        }
        var phi = n * (1 - 1 / primes[i]);
        if (i != j) {
            phi *= (1 - 1 / primes[j]);
        }
        if (!is_perm(n, phi)) {
            continue;
        }
        var ratio = n / phi;
        if (typeof min_ratio == 'undefined' || ratio < min_ratio) {
            min_ratio = ratio;
            n_for_min_ratio = n;
        }
    }
}

console.log(n_for_min_ratio);

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

function is_perm(num1, num2) {
    var digits1 = num1.toString().split('').sort().join('');
    var digits2 = num2.toString().split('').sort().join('');

    return digits1 == digits2;
}
