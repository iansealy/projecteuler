#!/usr/bin/env node

// Diophantine reciprocals I

var program = require('commander');

program
    .version('0.1.0')
    .description('Diophantine reciprocals I')
    .option('-l, --limit <int>', 'The minimum number of distinct solutions',
        Number, 1000)
    .parse(process.argv);

var primes = get_primes_up_to(program.limit);

var n = 0;
var solutions = 0;
while (solutions <= program.limit) {
    n++;
    var num_divisors = get_num_divisors(n * n, primes);
    solutions = (num_divisors + 1) / 2;
}

console.log(n);

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

function get_num_divisors(number, primes) {
    var num_divisors = 1;

    for (var i = 0; i <= primes.length; i++) {
        if (primes[i] * primes[i] > number) {
            break;
        }
        var exponent = 1;
        while (number % primes[i] == 0) {
            exponent++;
            number /= primes[i];
        }
        num_divisors *= exponent;
    }

    return num_divisors;
}
