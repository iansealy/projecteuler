#!/usr/bin/env node

// Digit fifth powers

var program = require('commander');

program
    .version('0.1.0')
    .description('Digit fifth powers')
    .option('-p, --power <int>', 'The power to raise digits by', Number, 5)
    .parse(process.argv);

var total_sum = 0;

// Work out maximum number of digits
// e.g.            5 * 59049 (295245) > 99999
// e.g.            6 * 59049 (354294) < 999999
var max_per_digit = Math.pow(9, program.power);
var max_digits = 1;
while (max_digits * max_per_digit > Math.pow(10, max_digits) - 1) {
    max_digits++;
}

var number = 2;
var max_number = Math.pow(10, max_digits);
while (number < max_number) {
    var digits = number.toString().split('');
    var sum = 0;
    for (var i = 0; i < digits.length; i++) {
        sum += Math.pow(parseInt(digits[i]), program.power);
    }
    if (sum == number) {
        total_sum += number;
    }
    number++;
}

console.log(total_sum);
