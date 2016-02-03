#!/usr/bin/env node

// Odd period square roots

var program = require('commander');

program
    .version('0.1.0')
    .description('Odd period square roots')
    .option('-l, --limit <int>',
        'The limit on N, the number whose square root is to be taken',
        Number, 10000)
    .parse(process.argv);

var odd_count = 0;
for (var n = 2; n <= program.limit; n++) {
    if (Math.sqrt(n) == Math.floor(Math.sqrt(n))) {
        continue;
    }

    var m = [0];
    var d = [1];
    var a = [Math.floor(Math.sqrt(n))];

    while (true) {
        m.push(d[d.length - 1] * a[a.length - 1] - m[m.length - 1]);
        d.push((n - m[m.length - 1] * m[m.length - 1]) / d[d.length - 1]);
        a.push(Math.floor((a[0] + m[m.length - 1]) / d[d.length - 1]));
        if (a[a.length - 1] == 2 * a[0]) {
            break;
        }
    }
    if (a.length % 2 == 0) {
        odd_count++;
    }
}

console.log(odd_count);
