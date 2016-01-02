#!/usr/bin/env node

// Digit factorials

var factorial_of = [];
for (var i = 0; i < 10; i++) {
    factorial_of.push(factorial(i));
}

var sum = 0;
var max = factorial_of[9] * 7;
for (var i = 10; i <= max; i++) {
    digits = i.toString().split('');
    var factorial_sum = 0;
    for (var j = 0; j < digits.length; j++) {
        factorial_sum += factorial_of[digits[j]];
    }
    if (i == factorial_sum) {
        sum += i;
    }
}

console.log(sum);

function factorial(number) {
    var factorial = 1;

    while (number > 1) {
        factorial *= number;
        number--;
    }

    return factorial;
}
