#!/usr/bin/env node

// Powerful digit sum

var LIMIT = 99;

var max_digit_sum = 0;
for (var a = 2; a <= LIMIT; a++) {
    var digits = a.toString().split('').reverse();
    for (var b = 2; b <= LIMIT; b++) {
        var new_digits = [];
        var carry = 0;
        for (var i = 0; i < digits.length; i++) {
            var product = parseInt(digits[i]) * a + (carry || 0);
            var last_digit_of_product = parseInt(product.toString().slice(-1));
            new_digits.push(last_digit_of_product);
            carry = parseInt(product.toString().slice(0, -1));
        }
        if (carry) {
            var carry_digits = carry.toString().split("").reverse();
            for (var i = 0; i < carry_digits.length; i++) {
                new_digits.push(parseInt(carry_digits[i]));
            }
        }
        digits = new_digits;
        var digit_sum = 0;
        for (var i = 0; i < digits.length; i++) {
            digit_sum += digits[i];
        }
        if (digit_sum > max_digit_sum) {
            max_digit_sum = digit_sum;
        }
    }
}

console.log(max_digit_sum);
