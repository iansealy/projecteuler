#!/usr/bin/env node

// Largest prime factor

var program = require('commander');

program
    .version('0.1.0')
    .description('Largest prime factor')
    .option('-n, --number <int>',
        'The number to find the largest prime factor of', Number, 600851475143)
    .parse(process.argv);

var number = program.number;
var div = 2;
while (div <= Math.floor(Math.sqrt(number))) {
    while (number % div == 0) {
        number = number / div;
    }
    if (div > 2) {
        div += 2;
    } else {
        div++;
    }
}

console.log(number);
