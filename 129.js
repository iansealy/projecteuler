#!/usr/bin/env node

// Repunit divisibility

var program = require('commander');

program
    .version('0.1.0')
    .description('Repunit divisibility')
    .option('-m, --minimum <int>', 'The minimum value of A(n)', Number, 1000000)
    .parse(process.argv);


var n = program.minimum;
while (true) {
    n++;
    if (n % 2 == 0 || n % 5 == 0) {
        continue;
    }
    var rkmodn = 1;
    var k = 1;
    while (rkmodn % n != 0) {
        k++;
        rkmodn = (rkmodn * 10 + 1) % n;
    }
    if (k > program.minimum) {
        break;
    }
}

console.log(n);
