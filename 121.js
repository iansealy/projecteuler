#!/usr/bin/env node

// Disc game prize fund

var program = require('commander');

program
    .version('0.1.0')
    .description('Disc game prize fund')
    .option('-t, --turns <int>', 'The number of turns', Number, 15)
    .parse(process.argv);

var sum = require('compute-sum');

var outcomes = [];
var prev_outcomes = [1, 1];
var turn = 1;
while (turn < program.turns) {
    turn++;
    outcomes = Array(program.turns + 2).join('0').split('').map(parseFloat);
    for (var blue = 0; blue < turn; blue++) {
        outcomes[blue] += prev_outcomes[blue];
    }
    for (var red = 1; red <= turn; red++) {
        outcomes[red] += prev_outcomes[red - 1] * turn;
    }
    prev_outcomes = outcomes;
}

var total = sum(outcomes);
var num_win = Math.floor((program.turns + 1) / 2);
var win = sum(outcomes.slice(0, num_win));

console.log(Math.floor(total / win));
