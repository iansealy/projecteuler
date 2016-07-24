#!/usr/bin/env node

// Non-bouncy numbers

var program = require('commander');

program
    .version('0.1.0')
    .description('Non-bouncy numbers')
    .option('-e, --exponent <int>', 'Maximum value of n as an exponent of 10',
        Number, 100)
    .parse(process.argv);

var count_increasing = (function() {
    var memo = {};

    return function(last_digit, length) {
        var key = last_digit.toString() + ':' + length.toString();

        if (key in memo) {
            return memo[key];
        }

        if (length == 1) {
            memo[key] = 1;
            return 1;
        }

        var count = 0;
        for (var prev = 1; prev <= last_digit; prev++) {
            count += count_increasing(prev, length - 1);
        }

        memo[key] = count;
        return count;
    };
})();

var count_decreasing = (function() {
    var memo = {};

    return function(last_digit, length) {
        var key = last_digit.toString() + ':' + length.toString();

        if (key in memo) {
            return memo[key];
        }

        if (length == 1) {
            memo[key] = 1;
            return 1;
        }

        var count = 0;
        for (var prev = last_digit; prev <= 9; prev++) {
            count += count_decreasing(prev, length - 1);
        }

        memo[key] = count;
        return count;
    };
})();

var increasing = 0;
for (var num_digits = 1; num_digits <= program.exponent; num_digits++) {
    for (var last_digit = 1; last_digit <= 9; last_digit++) {
        increasing += count_increasing(last_digit, num_digits);
    }
}

var decreasing = 0;
for (var num_digits = 1; num_digits <= program.exponent; num_digits++) {
    for (var last_digit = 0; last_digit <= 9; last_digit++) {
        decreasing += count_decreasing(last_digit, num_digits);
    }
    decreasing--;
}

var double_count = 9 * program.exponent;

console.log(increasing + decreasing - double_count);
