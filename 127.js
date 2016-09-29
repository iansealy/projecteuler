#!/usr/bin/env node

// abc-hits

var program = require('commander');

program
    .version('0.1.0')
    .description('abc-hits')
    .option('-l, --limit <int>', 'The maximum number', Number, 120000)
    .parse(process.argv);

var range = require('array-range');

var radicals = Array(program.limit + 2).join('1').split('').map(parseFloat);
for (var n = 2; n <= program.limit; n++) {
    if (radicals[n] == 1) {
        radicals[n] = n;
        var multiple = n + n;
        while (multiple <= program.limit) {
            radicals[multiple] *= n;
            multiple += n;
        }
    }
}

var indices = range(1, program.limit + 1).sort(function(a, b) {
    return radicals[a] - radicals[b] || a - b;
});

var pair = {};
for (var i = 0; i < indices.length; i++) {
    var c = indices[i];
    var rad_a_or_b_limit = Math.floor(Math.sqrt(c / radicals[c]));
    for (var j = 0; j < indices.length; j++) {
        var a_or_b = indices[j];
        if (radicals[a_or_b] > rad_a_or_b_limit) {
            break;
        }
        if (a_or_b >= c) {
            continue;
        }
        var a = a_or_b;
        var b = c - a_or_b;
        if (a > b) {
            a = c - a_or_b;
            b = a_or_b;
        }
        if (radicals[a] * radicals[b] * radicals[c] >= c) {
            continue;
        }
        if (gcd(a, b) > 1) {
            continue;
        }
        if (!pair[a]) {
            pair[a] = {};
        }
        pair[a][b] = true;
    }
}

var total = 0;
for (a in pair) {
    for (b in pair[a]) {
        total += parseInt(a) + parseInt(b);
    }
}

console.log(total);

function gcd(int1, int2) {
    if (int1 > int2) {
        var tmp = int2;
        int2 = int1;
        int1 = tmp;
    }

    while (int1) {
        var tmp = int2;
        int2 = int1;
        int1 = tmp % int1;
    }

    return int2;
}
