#!/usr/bin/env node

// Large non-Mersenne prime

var POWER = 7830457;
var MULTIPLIER = 28433;
var DIGITS = 1e10;

var num = 1;
for (var i = 0; i < POWER; i++) {
    num *= 2;
    num %= DIGITS;
}

num *= MULTIPLIER;
num++;
num %= DIGITS;

console.log(num);
