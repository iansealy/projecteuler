#!/usr/bin/env node

// Even Fibonacci numbers

var MAX_FIB = 4000000;

var fib1 = 1;
var fib2 = 1;
var sum_even = 0;
while (fib2 < MAX_FIB) {
    var tmp = fib2
    fib2 = fib1 + fib2
    fib1 = tmp
    if (fib1 % 2 == 0) {
        sum_even += fib1;
    }
}

console.log(sum_even);
