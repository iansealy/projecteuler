#!/usr/bin/env node

// Cuboid route

var program = require('commander');

program
    .version('0.1.0')
    .description('Cuboid route')
    .option('-t, --target <int>',
        'The target number of distinct cuboids', Number, 1000000)
    .parse(process.argv);

var total = 0;
var m = 1;
while (total < program.target) {
    for (var i = 1; i <= m; i++) {
        for (var j = i; j <= m; j++) {
            var route = Math.sqrt((i + j) * (i + j) + m * m);
            if (Math.floor(route) == route) {
                total++;
            }
        }
    }
    m++;
}

console.log(m - 1);
