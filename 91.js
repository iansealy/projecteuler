#!/usr/bin/env node

// Right triangles with integer coordinates

var program = require('commander');

program
    .version('0.1.0')
    .description('Right triangles with integer coordinates')
    .option('-m, --max <int>', 'The maximum x or y coordinate', Number, 50)
    .parse(process.argv);

var count = 0;

for (var x1 = 0; x1 <= program.max; x1++) {
    for (var y1 = 0; y1 <= program.max; y1++) {
        if (x1 == 0 && y1 == 0) {
            continue;
        }
        var op = [x1, y1];
        for (var x2 = 0; x2 <= program.max; x2++) {
            for (var y2 = 0; y2 <= program.max; y2++) {
                if (x2 == 0 && y2 == 0) {
                    continue;
                }
                if (x1 == x2 && y1 == y2) {
                    continue;
                }
                var oq = [x2, y2];
                var pq = [x2 - x1, y2 - y1];
                if (!dot_product(op, oq) ||
                    !dot_product(op, pq) ||
                    !dot_product(oq, pq)) {
                    count++;
                }
            }
        }
    }
}

console.log(count / 2);

function dot_product(v1, v2) {
    return v1[0] * v2[0] + v1[1] * v2[1];
}
