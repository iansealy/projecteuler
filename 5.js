#!/usr/bin/env node

// Smallest multiple

var program = require('commander');

program
    .version('0.1.0')
    .description('Smallest multiple')
    .option('-n, --max_num <int>',
        'The number ending the sequence to find the smallest multiple of',
        Number, 20)
    .parse(process.argv);

multiple_count_for = {};
for (var i = 2; i <= program.max_num; i++) {
    var count_for = get_factors(i);
    for (var factor in count_for) {
        if (!(factor in multiple_count_for) ||
            count_for[factor] > multiple_count_for[factor]) {
            multiple_count_for[factor] = count_for[factor];
        }
    }
}

var min_multiple = 1;
for (var factor in multiple_count_for) {
    min_multiple *= Math.pow(factor, multiple_count_for[factor]);
}

console.log(min_multiple);

function get_factors(number) {
    count_for = {};

    div = 2;
    while (div <= Math.floor(Math.sqrt(number))) {
        while (number % div == 0) {
            number = number / div;
            if (div in count_for) {
                count_for[div]++;
            } else {
                count_for[div] = 1;
            }
        }
        // Don't bother testing even numbers (except two)
        if (div > 2) {
            div += 2;
        } else {
            div++;
        }
    }

    if (number > 1) {
        count_for[number] = 1;
    }

    return count_for;
}
