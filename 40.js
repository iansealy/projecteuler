#!/usr/bin/env node

// Champernowne's constant

console.log(get_digit(1) * get_digit(10) * get_digit(100) * get_digit(1000) *
    get_digit(10000) * get_digit(100000) * get_digit(1000000));

function get_digit(n) {
    var num_digits = 1;
    var range_start = 1;
    var range_end = 9;
    while (range_end < n) {
        num_digits++;
        range_start = range_end + 1;
        range_end += num_digits * 9 * Math.pow(10, num_digits - 1);
    }
    var range_ordinal = Math.floor((n - range_start) / num_digits);
    var first_in_range = Math.pow(10, num_digits - 1);
    var number = first_in_range + range_ordinal;
    var digit_ordinal = range_ordinal % num_digits;
    var digit = parseInt(number.toString().substr(digit_ordinal, 1));

    return digit;
}
