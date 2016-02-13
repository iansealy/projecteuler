#!/usr/bin/env node

// Counting fractions

var program = require('commander');

program
    .version('0.1.0')
    .description('Counting fractions')
    .option('-l, --limit <int>', 'The limit on d', Number, 1000000)
    .parse(process.argv);

var sieve_limit = Math.floor(Math.floor(Math.sqrt(program.limit - 1)) / 2);
var max_index = Math.floor((program.limit - 1) / 2);
var cache = [];
for (var n = 1; n <= sieve_limit; n++) {
    if (!cache[n]) {
        var p = 2 * n + 1;
        var k = 2 * n * (n + 1);
        while (k <= max_index) {
            if (!cache[k]) {
                cache[k] = p;
            }
            k += p;
        }
    }
}
var multiplier = 1;
while (multiplier <= program.limit) {
    multiplier *= 2;
}
multiplier /= 2;
var count = multiplier - 1;
multiplier /= 2;
var step_index = Math.floor((Math.floor(program.limit / multiplier) + 1) / 2);
for (var n = 1; n <= max_index; n++) {
    if (n == step_index) {
        multiplier /= 2;
        step_index =
            Math.floor((Math.floor(program.limit / multiplier) + 1) / 2);
    }
    if (!cache[n]) {
        cache[n] = 2 * n;
        count += multiplier * cache[n];
    } else {
        var p = cache[n];
        var cofactor = Math.floor((2 * n + 1) / p);
        var factor = p;
        if (cofactor % p) {
            factor = p - 1;
        }
        cache[n] = factor * cache[Math.floor(cofactor / 2)];
        count += multiplier * cache[n];
    }
}

console.log(count);
