#!/usr/bin/env node

// Square digit chains

var MAX = 10000000;

var count = 0;

cache = {
    '1': 1,
    '89': 89,
};

for (var num = 2; num < MAX; num++) {
    var chain = [];
    var final;
    var n = num.toString().split('').sort().join('');
    while (true) {
        if (n in cache) {
            final = cache[n];
            break;
        }
        chain.push(n);
        var sum = 0;
        digits = n.toString().split('');
        for (var i = 0; i < digits.length; i++) {
            sum += parseInt(digits[i]) * parseInt(digits[i]);
        }
        n = sum;
    }
    if (final == 89) {
        count++;
    }
    for (var i = 0; i < chain.length; i++) {
        cache[n] = final;
    }
}

console.log(count);
