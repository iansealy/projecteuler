#!/usr/bin/env node

// Optimum polynomial

var MAX_N = 11;

var seq = [];
for (var n = 1; n <= MAX_N; n++) {
    var val = 0;
    var sign = 1;
    for (var pow = 0; pow <= 10; pow++) {
        val += sign * Math.pow(n, pow);
        sign *= -1;
    }
    seq.push(val);
}

var fits_sum = 0;

for (var k = 1; k < MAX_N; k++) {
    var potential_fit = 0;
    for (var i = 1; i <= k; i++) {
        var numer = 1;
        var denom = 1;
        for (var j = 1; j <= k; j++) {
            if (i == j) {
                continue
            }
            numer *= (k + 1 - j);
            denom *= (i - j);
        }
        potential_fit += seq[i - 1] * numer / denom;
    }
    if (potential_fit != seq[k]) {
        fits_sum += potential_fit;
    }
}

console.log(fits_sum);
