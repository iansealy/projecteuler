#!/usr/bin/env node

// Ordered fractions

var program = require('commander');

program
    .version('0.1.0')
    .description('Ordered fractions')
    .option('-l, --limit <int>', 'The maximum denominator', Number, 1000000)
    .parse(process.argv);

var RIGHT_FRAC = [3, 7];

var left_frac = [2, 7];
for (var d = 2; d <= program.limit; d++) {
    var start_n = Math.floor(left_frac[0] / left_frac[1] * d);
    var end_n = Math.floor(RIGHT_FRAC[0] / RIGHT_FRAC[1] * d) + 1;
    for (var n = start_n; n <= end_n; n++) {
        if (compare_fractions(n, d, RIGHT_FRAC[0], RIGHT_FRAC[1]) >= 0) {
            continue;
        }
        if (compare_fractions(n, d, left_frac[0], left_frac[1]) > 0) {
            left_frac = [n, d];
        }
    }
}

console.log(left_frac[0]);

function compare_fractions(numer1, denom1, numer2, denom2) {
    return numer1 * denom2 - numer2 * denom1;
}
