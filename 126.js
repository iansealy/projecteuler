#!/usr/bin/env node

// Cuboid layers

var program = require('commander');

program
    .version('0.1.0')
    .description('Cuboid layers')
    .option('-c, --cuboids <int>', 'The number of cuboids', Number, 1000)
    .parse(process.argv);

var first;
var limit = program.cuboids * 10;
while (typeof first == 'undefined') {
    limit *= 2;
    var count = Array(limit).join('0').split('').map(parseFloat);
    for (var x = 1; x <= limit; x++) {
        if (count_cuboids(x, 1, 1, 1) >= limit) {
            break
        }
        for (var y = 1; y <= x; y++) {
            if (count_cuboids(x, y, 1, 1) >= limit) {
                break
            }
            for (var z = 1; z <= y; z++) {
                if (count_cuboids(x, y, z, 1) >= limit) {
                    break
                }
                for (var n = 1; n <= limit; n++) {
                    var total = count_cuboids(x, y, z, n);
                    if (total >= limit) {
                        break;
                    }
                    count[total]++;
                }
            }
        }
    }
    for (var n = 1; n <= limit; n++) {
        if (count[n] == program.cuboids) {
            first = n;
            break;
        }
    }
}

console.log(first);

function count_cuboids(x, y, z, n) {
    var faces = 2 * (x * y + y * z + z * x);
    var lines = (n - 1) * 4 * (x + y + z);
    var corners = (n - 2) * (n - 1) * 4;

    return faces + lines + corners;
}
