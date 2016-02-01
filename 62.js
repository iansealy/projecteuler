#!/usr/bin/env node

// Cubic permutations

var program = require('commander');

program
    .version('0.1.0')
    .description('Cubic permutations')
    .option('-p, --perms <int>',
        'The target number of digit permutations', Number, 5)
    .parse(process.argv);

var bigint = require('big-integer');

var current_digits = 1;
var num = 0;
var cubes_for = {};
var lowest_cube;
while (true) {
    num++;

    var cube = bigint(num).pow(3);

    if (current_digits < cube.toString().length) {
        // Check if finished
        for (var key in cubes_for) {
            if (cubes_for[key].length == program.perms) {
                var low_cube = cubes_for[key][0];
                if (typeof lowest_cube == 'undefined' ||
                    low_cube.lt(lowest_cube)) {
                    lowest_cube = low_cube;
                }
            }
        }

        // Reset for another digit range
        current_digits = cube.toString().length;
        cubes_for = {};
    }
    if (typeof lowest_cube != 'undefined') {
        break;
    }
    var key = cube.toString().split('').sort().join('');
    if (!cubes_for[key]) {
        cubes_for[key] = [];
    }
    cubes_for[key].push(cube);
}

console.log(lowest_cube.toString());
