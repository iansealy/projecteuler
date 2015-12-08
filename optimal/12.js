#!/usr/bin/env node

// Highly divisible triangular number

var program = require('commander');

program
    .version('0.1.0')
    .description('Highly divisible triangular number')
    .option('-d, --divisors <int>',
        'The minimum number of divisors the triangle number should have',
        Number, 500)
    .option('-l, --limit <int>',
        'The highest number to check when generating a list of primes',
        Number, 1000)
    .parse(process.argv);

primes = get_primes_up_to(program.limit);

// Triangle numbers are of form n*(n+1)*2
// D() = number of divisors
// D(triangle number) = D(n/2)*D(n+1) if n is even
// or D(n)*D((n+1)/2) if n+1 is even

var n = 3;
var num_divisors_n = 2; // Always 2 for a prime
var num_factors = 0;

while (num_factors <= program.divisors) {
    n++;
    var n1 = n;
    if (n1 % 2 == 0) {
        n1 /= 2;
    }
    var num_divisors_n1 = 1;

    for (var i = 0; i <= primes.length; i++) {
        if (primes[i] * primes[i] > n1) {
            // Got last prime factor with exponent of 1
            num_divisors_n1 *= 2;
            break;
        }

        var exponent = 1;
        while (n1 % primes[i] == 0) {
            exponent++;
            n1 /= primes[i];
        }
        if (exponent > 1) {
            num_divisors_n1 *= exponent;
        }
        if (n1 == 1) {
            break;
        }
    }

    num_factors = num_divisors_n * num_divisors_n1;
    num_divisors_n = num_divisors_n1;
}

console.log(n * (n - 1) / 2);

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
