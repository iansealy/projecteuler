#!/usr/bin/env node

// Sum square difference

var program = require('commander');

program
    .version('0.1.0')
    .description('Sum square difference')
    .option('-n, --max_num <int>',
        'The number ending the sequence to find the difference of', Number, 100)
    .parse(process.argv);

var sum_squares = 0;
var sum_sequence = 0;
for (var i = 1; i <= program.max_num; i++) {
    sum_squares += i * i;
    sum_sequence += i;
}
var square_sum = sum_sequence * sum_sequence;
var diff = square_sum - sum_squares;

console.log(diff);
