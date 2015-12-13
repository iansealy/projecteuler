#!/usr/bin/env node

// Number letter counts

var program = require('commander');

program
    .version('0.1.0')
    .description('Number letter counts')
    .option('-l, --limit <int>', 'The highest number to convert', Number, 1000)
    .parse(process.argv);

var sum = 0;
for (var i = 1; i <= program.limit; i++) {
    sum += get_in_words(i).length;
}

console.log(sum);

function get_in_words(num) {
    unit_for = [
        '', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight',
        'nine'
    ];
    teen_for = [
        '', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen',
        'seventeen', 'eighteen', 'nineteen'
    ];
    tens_for = [
        '', 'ten', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy',
        'eighty', 'ninety'
    ];

    // 1000 is only possible 4 digit number
    if (num == 1000) {
        return 'onethousand';
    }

    // Deal with 100s (don't require "and")
    if (num % 100 == 0) {
        return unit_for[num / 100] + 'hundred';
    }

    var words = '';

    // Deal with 100s part of 3 digit number and leave 1 or 2 digit number
    if (num > 100) {
        words += unit_for[Math.floor(num / 100)] + 'hundredand';
        num = num % 100;
    }

    // Numbers ending 01 to 09 (or just 1 to 9)
    if (num < 10) {
        return words + unit_for[num];
    }

    // Numbers ending 10, 20 .. 80, 90
    if (num % 10 == 0) {
        return words + tens_for[num / 10];
    }

    // Numbers ending 11 to 19
    if (num < 20) {
        return words + teen_for[num - 10];
    }

    // Remaining two digit numbers
    return words + tens_for[Math.floor(num / 10)] + unit_for[num % 10];
}
