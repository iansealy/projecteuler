#!/usr/bin/env node

// Fibonacci golden nuggets

var program = require('commander');

program
    .version('0.1.0')
    .description('Fibonacci golden nuggets')
    .option('-o, --ordinal <int>',
        'The required ordinal golden nugget', Number, 15)
    .parse(process.argv);

console.log(fib(2 * program.ordinal) * fib(2 * program.ordinal + 1));

function fib(n) {
    return parseInt((Math.pow(1 + Math.sqrt(5), n) -
            Math.pow(1 - Math.sqrt(5), n)) /
        (Math.pow(2, n) * Math.sqrt(5)) + 0.5);
}
