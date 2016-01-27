#!/usr/bin/env node

// Square root convergents

var LIMIT = 1000;

var num_fractions = 0;

var denom_prev1 = [5];
var denom_prev2 = [2];
for (var i = 3; i <= LIMIT; i++) {
    var denom = [];
    var numer = [];
    var carry_denom = 0;
    var carry_numer = 0;
    for (var j = 0; j < denom_prev1.length; j++) {
        var prev2_digit = denom_prev2.shift() || 0;
        var sum_denom = 2 * denom_prev1[j] + prev2_digit + (carry_denom || 0);
        var sum_numer = 3 * denom_prev1[j] + prev2_digit + (carry_numer || 0);
        var last_digit_of_sum_denom = parseInt(sum_denom.toString().slice(-1));
        var last_digit_of_sum_numer = parseInt(sum_numer.toString().slice(-1));
        denom.push(last_digit_of_sum_denom);
        numer.push(last_digit_of_sum_numer);
        carry_denom = parseInt(sum_denom.toString().slice(0, -1));
        carry_numer = parseInt(sum_numer.toString().slice(0, -1));
    }
    if (carry_denom) {
        var carry_digits = carry_denom.toString().split("").reverse();
        for (var j = 0; j < carry_digits.length; j++) {
            denom.push(parseInt(carry_digits[j]));
        }
    }
    if (carry_numer) {
        var carry_digits = carry_numer.toString().split("").reverse();
        for (var j = 0; j < carry_digits.length; j++) {
            numer.push(parseInt(carry_digits[j]));
        }
    }
    if (numer.length > denom.length) {
        num_fractions++;
    }
    denom_prev2 = denom_prev1;
    denom_prev1 = denom;
}

console.log(num_fractions);
