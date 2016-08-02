#!/usr/bin/env node

// Counting block combinations II

var program = require('commander');

program
    .version('0.1.0')
    .description('Counting block combinations II')
    .option('-m, --m <int>', 'Minimum block length', Number, 50)
    .parse(process.argv);

var TARGET = 1000000;

var ways = (function() {
    var memo = {};

    return function(min_block, total_len) {
        var key = min_block.toString() + ':' + total_len.toString();
        if (key in memo) {
            return memo[key];
        }

        var count = 1;

        if (total_len < min_block) {
            memo[key] = count;
            return count;
        }

        for (var start = 0; start <= total_len - min_block; start++) {
            var end = total_len - start;
            for (var block_len = min_block; block_len <= end; block_len++) {
                count += ways(min_block, total_len - start - block_len - 1);
            }
        }

        memo[key] = count;
        return count;
    };
})();

var n = program.m + 1;
while (ways(program.m, n) <= TARGET) {
    n++;
}

console.log(n);
