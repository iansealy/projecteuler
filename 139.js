#!/usr/bin/env node

// Pythagorean tiles

var LIMIT = 100000000;

var count = 0;
var mlimit = Math.floor(Math.sqrt(LIMIT));
for (var m = 2; m <= mlimit; m++) {
    var m2 = m * m;
    for (var n = 1; n < m; n++) {
        if ((m + n) % 2 == 0 || gcd(n, m) > 1) {
            continue;
        }
        var n2 = n * n;
        var a = m2 - n2;
        var b = 2 * m * n;
        var c = m2 + n2;
        var perimeter = a + b + c;
        if (perimeter >= LIMIT) {
            break;
        }
        var tiling = c / (b - a);
        if (tiling != Math.floor(tiling)) {
            continue;
        }
        var multiple = perimeter;
        while (multiple <= LIMIT) {
            count++;
            multiple += perimeter;
        }
    }
}

console.log(count);

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
