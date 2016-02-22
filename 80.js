#!/usr/bin/env node

// Square root digital expansion

var LIMIT = 100;
var BASE = 10;

var bigint = require('big-integer');

var total = 0;
var current_square = 0;
for (var num = 1; num <= LIMIT; num++) {
    if (Math.sqrt(num) == Math.floor(Math.sqrt(num))) {
        current_square = num;
        continue;
    }
    var sqrt = bigint(Math.sqrt(current_square));
    var div = bigint((num - current_square) * BASE * BASE);
    while (sqrt.toString().length < LIMIT) {
        var double = sqrt.multiply(2);
        var i = 0;
        while (true) {
            i++;
            if (double.multiply(BASE).plus(i).multiply(i).gt(div)) {
                i--;
                break;
            }
        }
        sqrt = sqrt.multiply(BASE).plus(i);
        div = div.minus(double.multiply(BASE).plus(i).multiply(i))
            .multiply(BASE).multiply(BASE);
    }
    var digits = sqrt.toString().split('');
    for (var i = 0; i < digits.length; i++) {
        total += parseInt(digits[i]);
    }
}

console.log(total);
