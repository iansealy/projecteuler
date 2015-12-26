#!/usr/bin/env node

// Number spiral diagonals

var program = require('commander');

program
    .version('0.1.0')
    .description('Number spiral diagonals')
    .option('-w, --width <int>', 'The width of the number spiral', Number, 1001)
    .parse(process.argv);

var sum = 1;
var current_width = 1;
var increment = 0;
var number = 1;

while (current_width < program.width) {
    current_width += 2;
    increment += 2;
    for (var i = 0; i < 4; i++) {
        number += increment;
        sum += number;
    }
}

console.log(sum);
