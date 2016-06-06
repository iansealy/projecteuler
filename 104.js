#!/usr/bin/env node

// Pandigital Fibonacci ends

var TRUNCATE = 1e10;
var LOG_PHI = Math.log10((1 + Math.sqrt(5)) / 2);
var LOG_ROOT5 = Math.log10(5) / 2;

var k = 2;
var fib1 = 1;
var fib2 = 1;
while (true) {
    k++;
    sum = fib1 + fib2;
    fib1 = fib2 % TRUNCATE;
    fib2 = sum % TRUNCATE;
    if (!is_pandigital(fib2)) {
        continue;
    }
    var log_fibk = k * LOG_PHI - LOG_ROOT5;
    var fibk = Math.floor(Math.pow(10, log_fibk - Math.floor(log_fibk)) *
        Math.pow(10, 8));
    if (is_pandigital(fibk)) {
        break;
    }
}

console.log(k);

function is_pandigital(num) {
    var digits = unique(num.toString().split(''));
    if (digits.length == num.toString().length) {
        return true;
    } else {
        return false;
    }
}

function unique(array) {
    return array.reduce(function(prev, cur) {
        if (prev.indexOf(cur) < 0) {
            prev.push(cur);
        }
        return prev;
    }, []);
}
