#!/usr/bin/env node

// Product-sum numbers

var program = require('commander');

program
    .version('0.1.0')
    .description('Product-sum numbers')
    .option('-m, --max <int>', 'The maximum set size', Number, 12000)
    .parse(process.argv);

var factors_for = {};
var min_prod_sum_for = {};

for (var n = 2; n <= program.max * 2; n++) {
    factors_for[n] = [];
    var limit = Math.floor(Math.sqrt(n));
    for (var low_factor = 2; low_factor <= limit; low_factor++) {
        if (n % low_factor) {
            continue;
        }
        var high_factor = n / low_factor;
        factors_for[n].push([low_factor, high_factor]);
        if (high_factor in factors_for) {
            for (var i = 0; i < factors_for[high_factor].length; i++) {
                var factors = factors_for[high_factor][i];
                if (low_factor > factors[0]) {
                    continue;
                }
                factors_for[n].push([low_factor].concat(factors));
            }
        }
    }
}

for (var n = 2; n <= program.max * 2; n++) {
    for (var i = 0; i < factors_for[n].length; i++) {
        var factors = factors_for[n][i];
        var sum = 0;
        for (var j = 0; j < factors.length; j++) {
            sum += factors[j];
        }
        if (sum > n) {
            continue;
        }
        var k = n - sum + factors.length;
        if (k > program.max) {
            continue;
        }
        if (!(k in min_prod_sum_for) || min_prod_sum_for[k] > n) {
            min_prod_sum_for[k] = n;
        }
    }
}

var prod_sum = {};
for (k in min_prod_sum_for) {
    prod_sum[min_prod_sum_for[k]] = true;
}
var sum_of_sums = 0;
var sums = Object.keys(prod_sum);
for (var i = 0; i < sums.length; i++) {
    sum_of_sums += parseInt(sums[i]);
}

console.log(sum_of_sums);
