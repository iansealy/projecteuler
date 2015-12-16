#!/usr/bin/env node

// Factorial digit sum

var program = require('commander');

program
    .version('0.1.0')
    .description('Factorial digit sum')
    .option('-f, --factorial <int>', 'The number to sum the factorial of',
        Number, 100)
    .parse(process.argv);

var digits = [1];

for (var number = 2; number <= program.factorial; number++) {
    var multiplied_digits = [];
    var carry = 0;
    for (var i = 0; i < digits.length; i++) {
        var sum = digits[i] * number + (carry || 0);
        var last_digit_of_sum = parseInt(sum.toString().slice(-1));
        multiplied_digits.push(last_digit_of_sum);
        carry = parseInt(sum.toString().slice(0, -1));
    }
    if (carry) {
        var carry_digits = carry.toString().split("").reverse();
        for (var i = 0; i < carry_digits.length; i++) {
            multiplied_digits.push(parseInt(carry_digits[i]));
        }
    }
    digits = multiplied_digits;
}

var digits_sum = 0;
for (var i = 0; i < digits.length; i++) {
    digits_sum += digits[i];
}

console.log(digits_sum);
