#!/usr/bin/env node

// Digit power sum

var program = require('commander');

program
    .version('0.1.0')
    .description('Digit power sum')
    .option('-o, --ordinal <int>',
        'The required ordinal of the sequence', Number, 30)
    .parse(process.argv);

var bigint = require('big-integer');

var sequence = [];
var digit_sum = 1;
while (sequence.length < 2 * program.ordinal) {
    digit_sum++;
    var power = bigint(digit_sum);
    while (power.toString().length < digit_sum) {
        power = power.multiply(digit_sum);
        if (power.lt(10)) {
            continue;
        }
        var digits = power.toString().split('');
        var power_sum = 0;
        for (var i = 0; i < digits.length; i++) {
            power_sum += parseInt(digits[i]);
        }
        if (power_sum == digit_sum) {
            sequence.push(power);
        }
    }
}

console.log(sequence.sort(function(a, b) {
    return a.compare(b);
})[program.ordinal - 1].toString());
