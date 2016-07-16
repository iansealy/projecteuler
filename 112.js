#!/usr/bin/env node

// Bouncy numbers

var program = require('commander');

program
    .version('0.1.0')
    .description('Bouncy numbers')
    .option('-p, --proportion <int>', 'Target proportion of bouncy numbers',
        Number, 99)
    .parse(process.argv);

var total = 100;
var bouncy = 0;
while (bouncy / total * 100 != program.proportion) {
    total++;
    if (is_bouncy(total)) {
        bouncy++;
    }
}

console.log(total);

function is_bouncy(num) {
    var digits = num.toString().split('');
    var seen_up = false;
    var seen_down = false;
    for (var i = 1; i < digits.length; i++) {
        if (parseInt(digits[i]) > parseInt(digits[i - 1])) {
            seen_up = true;
        } else if (parseInt(digits[i]) < parseInt(digits[i - 1])) {
            seen_down = true;
        }
        if (seen_up && seen_down) {
            return true;
        }
    }
    return false;
}
