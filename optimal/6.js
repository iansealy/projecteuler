#!/usr/bin/env node

// Sum square difference

var program = require('commander');

program
    .version('0.1.0')
    .description('Sum square difference')
    .option('-n, --max_num <int>',
        'The number ending the sequence to find the difference of', Number, 100)
    .parse(process.argv);

var max_num = program.max_num;
var sum_squares = (2 * max_num + 1) * (max_num + 1) * max_num / 6;
var square_sum = Math.pow(max_num * (max_num + 1) / 2, 2);

console.log(square_sum - sum_squares);
