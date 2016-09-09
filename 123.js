#!/usr/bin/env node

// Prime square remainders

var program = require('commander');

program
    .version('0.1.0')
    .description('Prime square remainders')
    .option('-l, --limit <int>', 'The minimum remainder',
        Number, 1e10)
    .parse(process.argv);

var primes = get_primes_up_to(Math.sqrt(program.limit) * 10);

for (var n = 1; n <= primes.length; n++) {
    if (n % 2 == 0) {
        continue;
    }
    var r = primes[n - 1] * n * 2;
    if (r > program.limit) {
        break;
    }
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
