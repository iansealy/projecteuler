#!/usr/bin/env node

// Lychrel numbers

var LIMIT = 10000;

var count = 0;
for (var num = 1; num < LIMIT; num++) {
    var digits = num.toString().split('');
    var is_lychrel = true;
    for (var i = 0; i < 50; i++) {
        digits = add_reverse(digits);
        if (is_palindrome(digits)) {
            is_lychrel = false;
            break;
        }
    }
    if (is_lychrel) {
        count++;
    }
}

console.log(count);

function add_reverse(digits) {
    var reverse_digits = digits.slice().reverse();
    var new_digits = [];
    var carry = 0;
    for (var i = 0; i < digits.length; i++) {
        var sum = parseInt(digits[i]) + parseInt(reverse_digits[i]) +
            (carry || 0);
        var last_digit_of_sum = parseInt(sum.toString().slice(-1));
        new_digits.push(last_digit_of_sum);
        carry = parseInt(sum.toString().slice(0, -1));
    }
    if (carry) {
        var carry_digits = carry.toString().split("").reverse();
        for (var i = 0; i < carry_digits.length; i++) {
            new_digits.push(parseInt(carry_digits[i]));
        }
    }

    return new_digits;
}

function is_palindrome(digits) {
    var reverse_digits = digits.slice().reverse();
    return digits.join('') == reverse_digits.join('');
}
