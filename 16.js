#!/usr/bin/env node

// Power digit sum

var program = require('commander');

program
    .version('0.1.0')
    .description('Power digit sum')
    .option('-p, --power <int>', 'The power to raise 2 to', Number, 1000)
    .parse(process.argv);

var digits = [1];

for (var i = 1; i <= program.power; i++) {
    var doubled_digits = [];
    var carry = 0;
    for (var j = 0; j < digits.length; j++) {
        var sum = digits[j] * 2 + (carry || 0);
        var last_digit_of_sum = parseInt(sum.toString().slice(-1));
        doubled_digits.push(last_digit_of_sum);
        carry = parseInt(sum.toString().slice(0, -1));
    }
    if (carry) {
        var carry_digits = carry.toString().split("").reverse();
        for (var j = 0; j < carry_digits.length; j++) {
            doubled_digits.push(parseInt(carry_digits[j]));
        }
    }
    digits = doubled_digits;
}

var digits_sum = 0;
for (var i = 0; i < digits.length; i++) {
    digits_sum += digits[i];
}

console.log(digits_sum);
