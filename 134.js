#!/usr/bin/env node

// Prime pair connection

var program = require('commander');

program
    .version('0.1.0')
    .description('Prime pair connection')
    .option('-l, --limit <int>', 'The maximum prime', Number, 1000000)
    .parse(process.argv);

var bigint = require('big-integer');

var all_primes = get_primes_up_to(program.limit * 1.1);
var primes = [];
for (var i = 0; i < all_primes.length; i++) {
    if (all_primes[i] >= 5) {
        primes.push(all_primes[i]);
    }
    if (all_primes[i] >= program.limit) {
        break;
    }
}

var sum = bigint(0);

for (var i = 0; i < primes.length - 1; i++) {
    var prime1 = primes[i];
    var prime2 = primes[i + 1];
    var n = prime2;
    var multiplier = 2;
    var digits = prime1.toString().length;
    while (n % Math.pow(10, digits) != prime1) {
        var potential_multiplier = 10;
        while (n % potential_multiplier == prime1 % potential_multiplier) {
            multiplier = potential_multiplier;
            potential_multiplier *= 10;
        }
        n += prime2 * multiplier;
    }
    sum = sum.add(n);
}

console.log(sum.toString());

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
