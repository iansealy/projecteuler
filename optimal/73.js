#!/usr/bin/env node

// Counting fractions in a range

var program = require('commander');

program
    .version('0.1.0')
    .description('Counting fractions in a range')
    .option('-l, --limit <int>', 'The limit on d', Number, 12000)
    .parse(process.argv);

var k0 = Math.floor(Math.sqrt(program.limit / 2));
var m0 = Math.floor(program.limit / (2 * k0 + 1));
var r_small = [];
var r_large = [];

for (var n = 5; n <= m0; n++) {
    r(n);
}
for (var j = k0 - 1; j >= 0; j--) {
    r(Math.floor(program.limit / (2 * j + 1)));
}

console.log(r_large[0]);

function f(n) {
    var q = Math.floor(n / 6);
    var r = n % 6;
    var f = q * (3 * q - 2 + r);
    if (r == 5) {
        f++;
    }

    return f;
}

function r(n) {
    var threshold = Math.floor(Math.sqrt(n / 2));
    var count = f(n);
    count -= f(Math.floor(n / 2));
    var m = 5;
    var k = Math.floor((n - 5) / 10);
    while (k >= threshold) {
        var next_k = Math.floor((Math.floor(n / (m + 1)) - 1) / 2);
        count -= ((k - next_k) * (r_small[m] || 0));
        k = next_k;
        m++;
    }
    while (k > 0) {
        m = Math.floor(n / (2 * k + 1));
        if (m <= m0) {
            count -= (r_small[m] || 0);
        } else {
            var i = Math.floor((Math.floor(program.limit / m) - 1) / 2);
            count -= (r_large[i] || 0);
        }
        k--;
    }
    if (n <= m0) {
        r_small[n] = count;
    } else {
        r_large[Math.floor((Math.floor(program.limit / n) - 1) / 2)] = count;
    }

    return;
}
