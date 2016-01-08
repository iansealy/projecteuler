#!/usr/bin/env node

// Integer right triangles

var MAX_SIDE = 1000 / 2;

var count = [];

for (var side1 = 1; side1 <= MAX_SIDE; side1++) {
    for (var side2 = side1; side2 <= MAX_SIDE; side2++) {
        var side3 = Math.sqrt(side1 * side1 + side2 * side2);
        if (Math.floor(side3) == side3) {
            if (!count[side1 + side2 + side3]) {
                count[side1 + side2 + side3] = 0;
            }
            count[side1 + side2 + side3]++;
        }
    }
}

var idx = 0;
var max = count[idx];
for (var i = 1; i < count.length; i++) {
    if (!max || count[i] > max) {
        idx = i;
        max = count[i];
    }
}

console.log(idx);
