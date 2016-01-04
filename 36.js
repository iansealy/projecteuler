#!/usr/bin/env node

// Double-base palindromes

var MAX = 1000000;

var sum = 0;

for (var num = 1; num < MAX; num++) {
    if (!is_palindrome(num)) {
        continue;
    }
    if (!is_palindrome(num.toString(2))) {
        continue;
    }
    sum += num;
}

console.log(sum);

function is_palindrome(number) {
    return number.toString().split('').reverse('').join('') == number;
}
