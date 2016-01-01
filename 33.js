#!/usr/bin/env node

// Digit cancelling fractions

var numerators = [];
var denominators = [];

for (var numerator = 10; numerator < 99; numerator++) {
    var numerator1 = Math.floor(numerator / 10);
    var numerator2 = numerator % 10;
    for (var denominator = numerator + 1; denominator < 100; denominator++) {
        var denominator1 = Math.floor(denominator / 10);
        var denominator2 = denominator % 10;
        if ((numerator1 == denominator2 && denominator1 > 0 &&
                numerator2 / denominator1 == numerator / denominator) ||
            (numerator2 == denominator1 && denominator2 > 0 &&
                numerator1 / denominator2 == numerator / denominator)) {
            numerators.push(numerator);
            denominators.push(denominator);
        }
    }
}

var numerator_product = numerators.reduce(function(a, b) {
    return a * b;
});
var denominator_product = denominators.reduce(function(a, b) {
    return a * b;
});

primes = get_primes_up_to(numerator_product);
for (var i = 0; i < primes.length; i++) {
    while (numerator_product % primes[i] == 0 &&
        denominator_product % primes[i] == 0) {
        numerator_product /= primes[i];
        denominator_product /= primes[i];
    }
}

console.log(denominator_product);

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
