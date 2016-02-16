#!/usr/bin/env node

// Digit factorial chains

var LIMIT = 1000000;
var TARGET = 60;

var factorials = get_factorials_up_to(9);

var chain_length_for = {};
var target_count = 0;
for (var num = 0; num < LIMIT; num++) {
    // Check cache
    var sorted_digits = num.toString().split('').sort().join('');
    if (chain_length_for[sorted_digits]) {
        if (chain_length_for[sorted_digits] == TARGET) {
            target_count++;
        }
        continue;
    }

    var chain_length = 1;
    var chain_num = num;
    var seen = {};
    seen[num] = true;
    while (true) {
        var digits = chain_num.toString().split('');
        chain_num = 0;
        for (var i = 0; i < digits.length; i++) {
            chain_num += factorials[digits[i]];
        }
        if (seen[chain_num]) {
            break;
        }
        seen[chain_num] = true;
        chain_length++;
    }

    // Cache
    chain_length_for[num] = chain_length;
    if (chain_length == TARGET) {
        target_count++;
    }
}

console.log(target_count);

function get_factorials_up_to(limit) {
    var factorials = [1];
    var factorial = 1;
    for (var num = 1; num <= limit; num++) {
        factorial *= num;
        factorials[num] = factorial;
    }

    return factorials;
}
