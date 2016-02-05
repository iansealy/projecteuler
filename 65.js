#!/usr/bin/env node

// Convergents of e

var program = require('commander');

program
    .version('0.1.0')
    .description('Convergents of e')
    .option('-l, --limit <int>', 'The number of convergents', Number, 100)
    .parse(process.argv);

var bigint = require('big-integer');

var a = [2];
for (var n = 1; n <= Math.floor((program.limit - 1) / 3) + 1; n++) {
    a.push(1, 2 * n, 1);
}

var numer = [bigint(2), bigint(3)];
for (var n = 2; n <= program.limit - 1; n++) {
    var next = numer[numer.length - 1].multiply(a[n]);
    next = next.add(numer[numer.length - 2]);
    numer.push(next);
}

var sum = 0;
var digits = numer[numer.length - 1].toString().split('');
for (var i = 0; i < digits.length; i++) {
    sum += parseInt(digits[i]);
}

console.log(sum);
