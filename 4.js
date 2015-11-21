#!/usr/bin/env node

// Largest palindrome product

var program = require('commander');

program
    .version('0.1.0')
    .description('Largest palindrome product')
    .option('-d, --digits <int>',
        'The number of digits in the numbers to be multiplied', Number, 3)
    .parse(process.argv);

var digits = program.digits;
var high_num = '9'.repeat(digits);
var max = 0;
for (var num1 = high_num; num1 > 0; num1--) {
    for (var num2 = high_num; num2 > 0; num2--) {
        if (num2 > num1) {
            continue;
        }
        var product = num1 * num2;
        if (product > max && is_palindrome(product)) {
            max = product;
        }
    }
}

console.log(max);

function is_palindrome(number) {
    return number.toString().split('').reverse('').join('') == number;
}
