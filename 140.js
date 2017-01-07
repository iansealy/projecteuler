#!/usr/bin/env node

// Modified Fibonacci golden nuggets

var program = require('commander');

program
    .version('0.1.0')
    .description('Modified Fibonacci golden nuggets')
    .option('-o, --ordinal <int>',
        'The ordinal of the last golden nugget', Number, 30)
    .parse(process.argv);

var sum = require('compute-sum');

var nuggets = [];
var n = 0;
var up_or_down = 1;
while (nuggets.length < program.ordinal) {
    n += up_or_down;
    var discriminant = Math.sqrt(5 * n * n + 14 * n + 1);
    if (Math.floor(discriminant) == discriminant) {
        nuggets.push(n);
        if (nuggets.length > 2) {
            up_or_down = -1;
            n = Math.floor(nuggets[nuggets.length - 2] *
                nuggets[nuggets.length - 1] / nuggets[nuggets.length - 3]);
        }
    }
}

console.log(sum(nuggets));
