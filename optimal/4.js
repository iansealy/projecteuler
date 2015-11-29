#!/usr/bin/env node

// Largest palindrome product

var program = require('commander');

program
    .version('0.1.0')
    .description('Largest palindrome product')
    .option('-d, --digits <int>',
        'The number of digits in the numbers to be multiplied', Number, 3)
    .parse(process.argv);

var high_num = '9'.repeat(program.digits);
var low_num = Math.pow(10, program.digits - 1);
var max = 0;
for (var num1 = high_num; num1 >= low_num; num1--) {
    var num2 = num1;
    var decrease = 1;
    if (num1 % 11) {
        num2 = Math.floor(num2 / 11) * 11;
        decrease = 11;
    }
    while (num2 >= low_num) {
        var product = num1 * num2;
        if (product > max && is_palindrome(product)) {
            max = product;
        }
        num2 -= decrease;
    }
}

console.log(max);

function is_palindrome(number) {
    return number.toString().split('').reverse('').join('') == number;
}
