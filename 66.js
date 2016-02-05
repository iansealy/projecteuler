#!/usr/bin/env node

// Diophantine equation

var program = require('commander');

program
    .version('0.1.0')
    .description('Diophantine equation')
    .option('-l, --limit <int>', 'The limit on D', Number, 1000)
    .parse(process.argv);

var bigint = require('big-integer');

var n_with_largest_x;
var largest_x = 0;
for (var n = 2; n <= program.limit; n++) {
    if (Math.sqrt(n) == Math.floor(Math.sqrt(n))) {
        continue;
    }

    var m = [0];
    var d = [1];
    var a = [Math.floor(Math.sqrt(n))];

    var x_prev2 = bigint(1);
    var x_prev1 = bigint(a[0]);
    var y_prev2 = bigint(0);
    var y_prev1 = bigint(1);

    while (true) {
        m.push(d[d.length - 1] * a[a.length - 1] - m[m.length - 1]);
        d.push((n - m[m.length - 1] * m[m.length - 1]) / d[d.length - 1]);
        a.push(Math.floor((a[0] + m[m.length - 1]) / d[d.length - 1]));

        var x = x_prev1.multiply(a[a.length - 1]).add(x_prev2);
        var y = y_prev1.multiply(a[a.length - 1]).add(y_prev2);

        if (x.multiply(x).minus((y.multiply(y).multiply(n))) == 1) {
            if (x.gt(largest_x)) {
                n_with_largest_x = n;
                largest_x = x;
            }
            break;
        }

        x_prev2 = x_prev1;
        x_prev1 = x;
        y_prev2 = y_prev1;
        y_prev1 = y;
    }
}

console.log(n_with_largest_x);
