#!/usr/bin/env node

// Counting summations

var program = require('commander');

program
    .version('0.1.0')
    .description('Counting summations')
    .option('-n, --number <int>', 'The number to express as sums', Number, 100)
    .parse(process.argv);

var pentagonal = (function() {
    var memo = {};

    return function(n) {
        if (!(n in memo)) {
            memo[n] = (3 * n * n - n) / 2;
        }
        return memo[n];
    };
})();

var partitions = (function() {
    var memo = {
        '0': 1,
    };

    return function(n) {
        if (n in memo) {
            return memo[n];
        }

        var parts = 0;
        var k = 1;
        while (true) {
            var pent = pentagonal(k);
            if (n - pent < 0) {
                break;
            }
            parts += Math.pow(-1, k - 1) * partitions(n - pent);
            k = k > 0 ? -k : -k + 1;
        }

        memo[n] = parts;
        return parts;
    };
})();

console.log(partitions(program.number) - 1);
