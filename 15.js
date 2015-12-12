#!/usr/bin/env node

// Lattice paths

var program = require('commander');

program
    .version('0.1.0')
    .description('Lattice paths')
    .option('-g, --grid_size <int>', 'The size of the grid', Number, 20)
    .parse(process.argv);

var size = program.grid_size;
console.log(Math.round(factorial(size + size) / Math.pow(factorial(size), 2)));

function factorial(number) {
    var factorial = 1;

    while (number > 1) {
        factorial *= number;
        number--;
    }

    return factorial;
}
