#!/usr/bin/env node

// 1000-digit Fibonacci number

var program = require('commander');

program
    .version('0.1.0')
    .description('1000-digit Fibonacci number')
    .option('-d, --digits <int>', 'The number of digits', Number, 1000)
    .parse(process.argv);

var ordinal = 1;
var fib1 = [1];
var fib2 = [1];
while (fib1.length < program.digits) {
    ordinal++;
    var carry = 0;
    var fib3 = [];
    for (var i = 0; i < fib2.length; i++) {
        var sum = fib2[i] + (fib1[i] || 0) + (carry || 0);
        var last_digit_of_sum = parseInt(sum.toString().slice(-1));
        fib3.push(last_digit_of_sum);
        carry = parseInt(sum.toString().slice(0, -1));
    }
    if (carry) {
        var carry_digits = carry.toString().split("").reverse();
        for (var i = 0; i < carry_digits.length; i++) {
            fib3.push(parseInt(carry_digits[i]));
        }
    }
    fib1 = fib2;
    fib2 = fib3;
}

console.log(ordinal);
