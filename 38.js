#!/usr/bin/env node

// Pandigital multiples

max_pandigital = 0;
number = 0;
got_max = false;

while (!got_max) {
    number++;
    if (number.toString().indexOf('0') >= 0) {
        continue;
    }
    var n = 1;
    while (true) {
        n++;
        var concat_product = number.toString();
        for (var multiple = 2; multiple <= n; multiple++) {
            concat_product += (multiple * number).toString();
        }
        if (concat_product.length < 9) {
            continue;
        }
        if (concat_product.length > 9 && n == 2) {
            got_max = true;
            break;
        }
        if (concat_product.length > 9) {
            break;
        }
        if (concat_product.indexOf('0') >= 0) {
            continue;
        }
        digits = unique(concat_product.split(''));
        if (digits.length != 9) {
            continue;
        }
        if (parseInt(concat_product) > max_pandigital) {
            max_pandigital = parseInt(concat_product);
        }
    }
}

console.log(max_pandigital);

function unique(array) {
    return array.reduce(function(prev, cur) {
        if (prev.indexOf(cur) < 0) {
            prev.push(cur);
        }
        return prev;
    }, []);
}
