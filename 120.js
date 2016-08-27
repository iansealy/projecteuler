#!/usr/bin/env node

// Square remainders

var total = 0;
for (var a = 3; a <= 1000; a++) {
    total += a * (a - 2 + a % 2)
}

console.log(total);
