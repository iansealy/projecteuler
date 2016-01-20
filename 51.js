#!/usr/bin/env node

// Prime digit replacements

var program = require('commander');

program
    .version('0.1.0')
    .description('Prime digit replacements')
    .option('-p, --prime_value <int>',
        'The value of the prime family', Number, 8)
    .parse(process.argv);

var digits = 1;
var smallest_prime;
while (typeof smallest_prime == 'undefined') {
    digits++;
    smallest_prime = get_smallest_prime(digits);
}

console.log(smallest_prime);

function get_smallest_prime(digits) {
    var limit = Math.pow(10, digits) - 1;
    var primes = get_primes_up_to(limit);
    primes = primes.filter(function(n) {
        return n.toString().length == digits;
    });
    is_prime = {};
    for (var i = 0; i < primes.length; i++) {
        is_prime[primes[i]] = true;
    }
    for (var n = 1; n < digits; n++) {
        var all_digits = [];
        for (var i = 0; i < digits; i++) {
            all_digits.push(i);
        }
        var combs = combinations(all_digits, n);
        for (var i = 0; i < combs.length; i++) {
            var prime_count = {};
            for (var j = 0; j < primes.length; j++) {
                var prime_base = primes[j].toString();
                var removed = {};
                for (var k = 0; k < combs[i].length; k++) {
                    removed[prime_base.substr(combs[i][k], 1)] = true;
                    prime_base = prime_base.substr(0, combs[i][k]) + 'x' +
                        prime_base.substr(combs[i][k] + 1);
                }
                if (Object.keys(removed).length == 1) {
                    if (!prime_count[prime_base]) {
                        prime_count[prime_base] = 0;
                    }
                    prime_count[prime_base]++;
                }
            }
            for (var prime_base in prime_count) {
                if (prime_count[prime_base] != program.prime_value) {
                    continue;
                }
                for (var replace = 0; replace < 10; replace++) {
                    var prime = prime_base;
                    prime = prime.replace(/x/g, replace.toString());
                    if (is_prime[prime]) {
                        return prime;
                    }
                }
            }
        }
    }

    return;
}

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

function combinations(group, n) {
    var combs = [];

    if (n == 1) {
        for (var i = 0; i < group.length; i++) {
            combs.push([group[i]]);
        }
        return combs;
    }

    var i = 0;
    while (i + n <= group.length) {
        var next = group.slice(i, i + 1);
        var rest = group.slice(i + 1);
        var rest_combs = combinations(rest, n - 1);
        for (var j = 0; j < rest_combs.length; j++) {
            combs.push(next.concat(rest_combs[j]));
        }
        i++;
    }

    return combs;
}
