#!/usr/bin/env node

// Pandigital products

var products = get_products(1, 9, 1234, 9876);
products = unique(products.concat(get_products(12, 98, 123, 987)));

var sum = products.reduce(function(a, b) {
    return a + b;
});

console.log(sum);

function get_products(lo_multiplicand, hi_multiplicand, lo_multiplier,
    hi_multiplier) {
    var products = [];

    for (var i = lo_multiplicand; i <= hi_multiplicand; i++) {
        if (i.toString().indexOf('0') >= 0) {
            continue;
        }
        for (var j = lo_multiplier; j <= hi_multiplier; j++) {
            if (j.toString().indexOf('0') >= 0) {
                continue;
            }
            var product = i * j;
            if (product >= 10000) {
                continue;
            }
            if (product.toString().indexOf('0') >= 0) {
                continue;
            }
            var digits = i.toString() + j.toString() + product.toString();
            digits = unique(digits.split(''));
            if (digits.length < 9) {
                continue;
            }
            products.push(product);
        }
    }

    return products;
}

function unique(array) {
    return array.reduce(function(prev, cur) {
        if (prev.indexOf(cur) < 0) {
            prev.push(cur);
        }
        return prev;
    }, []);
}
