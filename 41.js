#!/usr/bin/env node

// Pandigital prime

var max = 0;

// 8 and 9 digit pandigital numbers are divisible by 3 so not prime
// 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 = 45
// 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8     = 36
// 1 + 2 + 3 + 4 + 5 + 6 + 7         = 28
primes = get_primes_up_to(10000000);
for (var i = primes.length - 1; i >= 0; i--) {
    if (primes[i].toString().indexOf('0') >= 0) {
        continue;
    }
    var num_digits = primes[i].toString().length;
    var digits = unique(primes[i].toString().split(''));
    if (digits.length != num_digits) {
        continue;
    }
    if (Math.max.apply(Math, digits) > num_digits) {
        continue;
    }
    max = primes[i];
    break;
}

console.log(max);

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

function unique(array) {
    return array.reduce(function(prev, cur) {
        if (prev.indexOf(cur) < 0) {
            prev.push(cur);
        }
        return prev;
    }, []);
}
