#!/usr/bin/env node

// Permuted multiples

var num = 0;
while (true) {
    num++;
    if (num.toString().substr(0, 1) != '1') {
        continue;
    }
    var digits = num.toString().split('');
    digits.sort();
    digits = digits.join('');
    var all_match = true;
    for (var multiple = 2; multiple <= 6; multiple++) {
        var product = num * multiple;
        var multiple_digits = product.toString().split('');
        multiple_digits.sort();
        multiple_digits = multiple_digits.join('');
        if (digits != multiple_digits) {
            all_match = false;
            break;
        }
    }
    if (all_match) {
        break;
    }
}

console.log(num);
