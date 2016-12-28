#!/usr/bin/env node

// Special isosceles triangles

var program = require('commander');

program
    .version('0.1.0')
    .description('Special isosceles triangles')
    .option('-o, --ordinal <int>',
        'The ordinal of the last required isosceles triangle', Number, 12)
    .parse(process.argv);

var total = 0;
for (var n = 1; n <= program.ordinal; n++) {
    total += fib(6 * n + 3) / 2;
}

console.log(total);

function fib(n) {
    return parseInt((Math.pow(1 + Math.sqrt(5), n) -
            Math.pow(1 - Math.sqrt(5), n)) /
        (Math.pow(2, n) * Math.sqrt(5)) + 0.5);
}
