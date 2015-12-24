#!/usr/bin/env node

// Reciprocal cycles

var program = require('commander');

program
    .version('0.1.0')
    .description('Reciprocal cycles')
    .option('-d, --denominators <int>', 'The maximum denominator', Number, 999)
    .parse(process.argv);

var max_denominator = 0;
var max_cycle = 0;
for (var denominator = 2; denominator <= program.denominators; denominator++) {
    var remainder = 1 % denominator;
    var first_seen = {};
    var digit = 0;
    while (remainder) {
        digit++;
        remainder *= 10;
        var whole = Math.floor(remainder / denominator);
        var remainder = remainder % denominator;
        var key = whole.toString() + ':' + remainder.toString();
        if (first_seen[key]) {
            // Got cycle
            var cycle = digit - first_seen[key];
            if (cycle > max_cycle) {
                max_cycle = cycle;
                max_denominator = denominator;
            }
            remainder = 0;
        } else {
            first_seen[key] = digit;
        }
    }
}

console.log(max_denominator);
