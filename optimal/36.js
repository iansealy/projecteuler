#!/usr/bin/env node

// Double-base palindromes

var MAX = 1000000;

var sum = 0;
var i = 1;
var p = make_palindrome_base_2(i, 1);
while (p < MAX) {
    if (is_palindrome(p, 10)) {
        sum += p;
    }
    i++;
    p = make_palindrome_base_2(i, 1);
}
i = 1;
p = make_palindrome_base_2(i, 0);
while (p < MAX) {
    if (is_palindrome(p, 10)) {
        sum += p;
    }
    i++;
    p = make_palindrome_base_2(i, 0);
}

console.log(sum);

function make_palindrome_base_2(number, odd_length) {
    var result = number;

    if (odd_length) {
        number >>= 1;
    }

    while (number > 0) {
        result = (result << 1) + (number & 1);
        number >>= 1;
    }

    return result;
}

function is_palindrome(number, base) {
    var reversed = 0;
    var k = number;
    while (k > 0) {
        reversed = base * reversed + k % base;
        k = Math.floor(k / base);
    }

    return number == reversed;
}
