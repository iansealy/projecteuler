#!/usr/bin/env node

// Same differences

var program = require('commander');

program
    .version('0.1.0')
    .description('Same differences')
    .option('-l, --limit <int>', 'The maximum value of n',
        Number, 1000000)
    .option('-s, --solutions <int>', 'The number of distinct solutions',
        Number, 10)
    .parse(process.argv);

var count = {};
for (var d = 1; d <= program.limit; d++) {
    var z = 0;
    while (z <= program.limit) {
        z++;
        var n = 3 * d * d + 2 * d * z - z * z;
        if (n < 0) {
            break;
        }
        if (n > program.limit) {
            // Solve quadratic equation to determine when back below limit
            var sq_root = Math.sqrt((2 * d) * (2 * d) -
                4 * (program.limit - 3 * d * d));
            var z1 = Math.floor((2 * d - sq_root) / 2);
            var z2 = Math.floor((2 * d + sq_root) / 2);
            if (z1 > z) {
                z = z1 - 1;
            } else if (z2 > z) {
                z = z2 - 1;
            }
            continue;
        }
        if (!(n in count)) {
            count[n] = 0;
        }
        count[n]++;
    }
}

var total = 0;
for (n in count) {
    if (count[n] == 10) {
        total++;
    }
}

console.log(total);
