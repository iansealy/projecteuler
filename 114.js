#!/usr/bin/env node

// Counting block combinations I

var program = require('commander');

program
    .version('0.1.0')
    .description('Counting block combinations I')
    .option('-u, --units <int>', 'The length of the row', Number, 50)
    .parse(process.argv);

var MIN_BLOCK = 3;

var ways = (function() {
    var memo = {};

    return function(total_len) {
        if (total_len in memo) {
            return memo[total_len];
        }

        var count = 1;

        if (total_len < MIN_BLOCK) {
            memo[total_len] = count;
            return count;
        }

        for (var start = 0; start <= total_len - MIN_BLOCK; start++) {
            var end = total_len - start;
            for (var block_len = MIN_BLOCK; block_len <= end; block_len++) {
                count += ways(total_len - start - block_len - 1);
            }
        }

        memo[total_len] = count;
        return count;
    };
})();

console.log(ways(program.units));
