#!/usr/bin/env node

// Multiples of 3 and 5

var MAX_NUM = 1000;

console.log(sum_sequence(3) + sum_sequence(5) - sum_sequence(15));

function sum_sequence(step) {
    var last_int = Math.floor((MAX_NUM - 1) / step);
    return step * last_int * (last_int + 1) / 2;
}
