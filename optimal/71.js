#!/usr/bin/env node

// Ordered fractions

var program = require('commander');

program
    .version('0.1.0')
    .description('Ordered fractions')
    .option('-l, --limit <int>', 'The maximum denominator', Number, 1000000)
    .parse(process.argv);

var TARGET_FRAC = [3, 7];

var best_numer = 0;
var best_denom = 1;
var cur_denom = program.limit;
var min_denom = 1;
while (cur_denom >= min_denom) {
    var cur_numer =
        Math.floor((TARGET_FRAC[0] * cur_denom - 1) / TARGET_FRAC[1]);
    if (best_numer * cur_denom < cur_numer * best_denom) {
        best_numer = cur_numer;
        best_denom = cur_denom;
        var delta = TARGET_FRAC[0] * cur_denom - TARGET_FRAC[1] * cur_numer;
        min_denom = Math.floor(cur_denom / delta) + 1;
    }
    cur_denom--;
}

console.log(best_numer);
