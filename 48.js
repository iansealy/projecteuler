#!/usr/bin/env node

// Self powers

var NUM_DIGITS = 10;
var LAST_NUMBER = 1000;

var sum_end = 0;
for (var number = 1; number <= LAST_NUMBER; number++) {
    var power_end = number;
    for (var i = 1; i < number; i++) {
        power_end *= number;
        power_end = parseInt(power_end.toString().slice(-NUM_DIGITS));
    }
    sum_end += power_end;
    sum_end = parseInt(sum_end.toString().slice(-NUM_DIGITS));
}
sum_end = ('0000000000' + sum_end).slice(-NUM_DIGITS);

console.log(sum_end);
