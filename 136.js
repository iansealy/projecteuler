#!/usr/bin/env node

// Singleton difference

var program = require('commander');

program
    .version('0.1.0')
    .description('Singleton difference')
    .option('-l, --limit <int>', 'The maximum value of n',
        Number, 50000000)
    .parse(process.argv);

// x = y + d
// z = y - d
// x^2 - y^2 - z^2 = n
// (y + d)^2 -y^2 - (y - d)^2 = n
// 4dy - y^2 = n
// y(4d - y) = n
var count = new Array(program.limit + 1).join('0').split('').map(parseFloat);
for (var y = 1; y <= program.limit; y++) {
    for (var d = Math.floor(y / 4) + 1; d <= program.limit; d++) {
        if (y - d < 1) {
            break;
        }
        var n = y * (4 * d - y);
        if (n >= program.limit) {
            break;
        }
        count[n]++;
    }
}

var total = 0;
for (n in count) {
    if (count[n] == 1) {
        total++;
    }
}

console.log(total);
