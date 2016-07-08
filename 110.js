#!/usr/bin/env node

// Diophantine reciprocals II

var program = require('commander');

program
    .version('0.1.0')
    .description('Diophantine reciprocals II')
    .option('-l, --limit <int>', 'The minimum number of distinct solutions',
        Number, 4000000)
    .parse(process.argv);

var primes = get_primes_up_to(Math.sqrt(program.limit));
var max_primes = Math.ceil(Math.log(2 * program.limit) / Math.log(3));
primes = primes.slice(0, max_primes);

var exponent_set = [1];
var min_n2;
var prev_min_n2;
while (typeof prev_min_n2 == 'undefined' || min_n2 != prev_min_n2) {
    prev_min_n2 = min_n2;
    exponent_set.push(exponent_set[exponent_set.length - 1] + 2);
    var idx = new Array(max_primes + 1).join('0').split('').map(parseFloat);
    while (true) {
        var finished = true;
        for (var i = max_primes - 1; i >= 0; i--) {
            if (idx[i] != exponent_set.length - 1) {
                finished = false;
                break;
            }
        }
        if (finished) {
            break;
        }
        var next = idx[i] + 1;
        for (var j = i; j < idx.length; j++) {
            idx[j] = next;
        }
        var product = 1;
        for (var j = 0; j < max_primes; j++) {
            product *= exponent_set[idx[j]];
        }
        if (product > 2 * program.limit) {
            var exponents = [];
            for (var j = 0; j < max_primes; j++) {
                exponents.push(exponent_set[idx[max_primes - j - 1]]);
            }
            var n2 = 1;
            for (var j = 0; j < max_primes; j++) {
                n2 *= Math.pow(primes[j], (exponents[j] - 1));
            }
            if (typeof min_n2 != 'undefined' && n2 >= min_n2) {
                continue;
            }
            min_n2 = n2;
        }
    }
}

console.log(Math.sqrt(min_n2));

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
