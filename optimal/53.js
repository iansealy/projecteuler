#!/usr/bin/env node

// Combinatoric selections

var N = 100;

var greater_count = 0;
var r = 0;
var n = N;
var combs = 1;
while (r < n / 2) {
    var c_right = combs * (n - r) / (r + 1);
    if (c_right < 1000000) {
        r++;
        combs = c_right;
    } else {
        var c_up_right = combs * (n - r) / n;
        greater_count += n - 2 * r - 1;
        n--;
        combs = c_up_right;
    }
}

console.log(greater_count);
