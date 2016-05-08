#!/usr/bin/env node

// Arranged probability

var LIMIT = 1e12;

var blue = 85
var num = blue + 35;
while (num <= LIMIT) {
    var next_blue = 3 * blue + 2 * num - 2;
    var next_num = 4 * blue + 3 * num - 3;
    blue = next_blue;
    num = next_num;
}

console.log(blue);
