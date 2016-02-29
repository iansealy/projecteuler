#!/usr/bin/env node

// Prime power triples

var program = require('commander');

program
    .version('0.1.0')
    .description('Prime power triples')
    .option('-l, --limit <int>', 'The maximum sum', Number, 50000000)
    .parse(process.argv);

var primes = get_primes_up_to(Math.floor(Math.sqrt(program.limit)));

var squares = [];
var cubes = [];
var fourths = [];
for (var i = 0; i < primes.length; i++) {
    var square = primes[i] * primes[i];
    if (square < program.limit) {
        squares.push(square);
    }
    var cube = square * primes[i];
    if (cube < program.limit) {
        cubes.push(cube);
    }
    var fourth = cube * primes[i];
    if (fourth < program.limit) {
        fourths.push(fourth);
    }
}

var is_expressible = {};
for (var i = 0; i < fourths.length; i++) {
    for (var j = 0; j < cubes.length; j++) {
        for (var k = 0; k < squares.length; k++) {
            var sum = squares[k] + cubes[j] + fourths[i];
            if (sum >= program.limit) {
                break;
            }
            is_expressible[sum] = true;
        }
    }
}

console.log(Object.keys(is_expressible).length);

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
