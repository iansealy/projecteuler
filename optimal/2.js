#!/usr/bin/env node

// Even Fibonacci numbers

var MAX_FIB = 4000000;

var fib_even1 = 0;
var fib_even2 = 2;
var sum_even = 0;
while (fib_even2 < MAX_FIB) {
    var tmp = fib_even2;
    fib_even2 = 4 * fib_even2 + fib_even1;
    fib_even1 = tmp;
    sum_even += fib_even1;
}

console.log(sum_even);
