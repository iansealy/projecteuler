#!/usr/bin/env node

// Counting fractions in a range

var program = require('commander');

program
    .version('0.1.0')
    .description('Counting fractions in a range')
    .option('-l, --limit <int>', 'The limit on d', Number, 12000)
    .parse(process.argv);

var LEFT_FRAC = [1, 3];
var RIGHT_FRAC = [1, 2];

var count = 0;
for (var d = 2; d <= program.limit; d++) {
    var start_n = Math.floor(LEFT_FRAC[0] / LEFT_FRAC[1] * d);
    var end_n = Math.floor(RIGHT_FRAC[0] / RIGHT_FRAC[1] * d) + 1;
    for (var n = start_n; n <= end_n; n++) {
        if (compare_fractions(n, d, LEFT_FRAC[0], LEFT_FRAC[1]) <= 0) {
            continue;
        }
        if (compare_fractions(n, d, RIGHT_FRAC[0], RIGHT_FRAC[1]) >= 0) {
            break;
        }
        if (gcd(n, d) > 1) {
            continue;
        }
        count++
    }
}

console.log(count);

function compare_fractions(numer1, denom1, numer2, denom2) {
    return numer1 * denom2 - numer2 * denom1;
}

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
