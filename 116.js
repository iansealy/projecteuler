#!/usr/bin/env node

// Red, green or blue tiles

var program = require('commander');

program
    .version('0.1.0')
    .description('Red, green or blue tiles')
    .option('-u, --units <int>', 'The length of the row', Number, 50)
    .parse(process.argv);

var BLOCK_SIZES = [2, 3, 4];

var ways = (function() {
    var memo = {};

    return function(total_len, block_size) {
        var key = total_len.toString() + ':' + block_size.toString();
        if (key in memo) {
            return memo[key];
        }

        var count = 1;

        if (total_len < block_size) {
            memo[key] = count;
            return count;
        }

        for (var start = 0; start <= total_len - block_size; start++) {
            count += ways(total_len - start - block_size, block_size);
        }

        memo[key] = count;
        return count;
    };
})();

var total = 0;
for (var i = 0; i < BLOCK_SIZES.length; i++) {
    total += ways(program.units, BLOCK_SIZES[i]) - 1;
}

console.log(total);
