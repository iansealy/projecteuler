#!/usr/bin/env node

// Longest Collatz sequence

var program = require('commander');

program
    .version('0.1.0')
    .description('Longest Collatz sequence')
    .option('-l, --limit <int>',
        'The starting number below which to find the longest Collatz sequence',
        Number, 1000000)
    .parse(process.argv);

var cache = [];

var longest_chain_length = 0;
var longest_chain_start = 1;

for (var start = 2; start <= program.limit; start++) {
    var length = 0;
    var number = start;
    while (number > 1) {
        // Check if rest of chain is cached
        if (cache[number]) {
            length += cache[number];
            break;
        }

        length++;
        if (number % 2) {
            number = 3 * number + 1;
        } else {
            number /= 2;
        }
    }
    cache[start] = length;
    if (length > longest_chain_length) {
        longest_chain_length = length;
        longest_chain_start = start;
    }
}

console.log(longest_chain_start);
