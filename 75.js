#!/usr/bin/env node

// Singular integer right triangles

var LIMIT = 1500000;

var count = {};
var mlimit = Math.floor(Math.sqrt(LIMIT));
for (var m = 2; m <= mlimit; m++) {
    for (var n = 1; n < m; n++) {
        if ((m + n) % 2 == 0 || gcd(n, m) > 1) {
            continue;
        }
        var length = 2 * m * (m + n);
        var multiple = length;
        while (multiple <= LIMIT) {
            if (!count[multiple]) {
                count[multiple] = 0;
            }
            count[multiple]++;
            multiple += length;
        }
    }
}

var num = 0;
for (l in count) {
    if (count[l] == 1) {
        num++;
    }
}

console.log(num);

function gcd(int1, int2) {
    if (int1 > int2) {
        var tmp = int2;
        int2 = int1;
        int1 = tmp;
    }

    while (int1) {
        var tmp = int2;
        int2 = int1;
        int1 = tmp % int1;
    }

    return int2;
}
