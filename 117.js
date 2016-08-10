#!/usr/bin/env node

// Red, green, and blue tiles

var program = require('commander');

program
    .version('0.1.0')
    .description('Red, green, and blue tiles')
    .option('-u, --units <int>', 'The length of the row', Number, 50)
    .parse(process.argv);

var BLOCK_SIZES = [2, 3, 4];

var ways = (function() {
    var memo = {};

    return function(total_len) {
        if (total_len in memo) {
            return memo[total_len];
        }

        var count = 1;

        if (total_len < BLOCK_SIZES[0]) {
            memo[total_len] = count;
            return count;
        }

        for (var i = 0; i < BLOCK_SIZES.length; i++) {
            for (var start = 0; start <= total_len - BLOCK_SIZES[i]; start++) {
                count += ways(total_len - start - BLOCK_SIZES[i]);
            }
        }

        memo[total_len] = count;
        return count;
    };
})();

console.log(ways(program.units));
