#!/usr/bin/env node

// Almost equilateral triangles

var MAX = 1e9;

var total = 0;

var m = 1;
var below_max = true;
while (below_max) {
    m++;
    var m2 = m * m;
    var n = m % 2 ? 0 : -1;
    while (n < m - 2) {
        n += 2;
        var n2 = n * n;
        var a = m2 - n2;
        var b = 2 * m * n;
        var c = m2 + n2;
        if (Math.abs(2 * a - c) != 1 && Math.abs(2 * b - c) != 1) {
            continue;
        }
        if (2 * (a + c) > MAX && 2 * (b + c) > MAX) {
            below_max = false;
            break;
        }
        if (Math.abs(2 * a - c) == 1) {
            total += 2 * (a + c);
        }
        if (Math.abs(2 * b - c) == 1) {
            total += 2 * (b + c);
        }
    }
}

console.log(total);
