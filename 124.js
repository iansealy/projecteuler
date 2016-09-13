#!/usr/bin/env node

// Ordered radicals

var program = require('commander');

program
    .version('0.1.0')
    .description('Ordered radicals')
    .option('-l, --limit <int>', 'The maximum value of n', Number, 100000)
    .option('-o, --ordinal <int>', 'The required ordinal', Number, 10000)
    .parse(process.argv);

var range = require('array-range');

var radicals = Array(program.limit + 2).join('1').split('').map(parseFloat);
for (var n = 2; n <= program.limit; n++) {
    if (radicals[n] == 1) {
        radicals[n] = n;
        var multiple = n + n;
        while (multiple <= program.limit) {
            radicals[multiple] *= n;
            multiple += n;
        }
    }
}

console.log(range(1, program.limit + 1).sort(function(a, b) {
    return radicals[a] - radicals[b] || a - b;
})[program.ordinal - 1]);
