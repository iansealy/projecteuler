#!/usr/bin/env node

// Monopoly odds

var program = require('commander');

program
    .version('0.1.0')
    .description('Monopoly odds')
    .option('-s, --sides <int>', 'Number of die sides', Number, 4)
    .parse(process.argv);

var SQUARES = 40;
var CC_CARDS = 16;
var CH_CARDS = 16;
var GO = 0;
var A1 = 1;
var CC1 = 2;
var A2 = 3;
var T1 = 4;
var R1 = 5;
var B1 = 6;
var CH1 = 7;
var B2 = 8;
var B3 = 9;
var JAIL = 10;
var C1 = 11;
var U1 = 12;
var C2 = 13;
var C3 = 14;
var R2 = 15;
var D1 = 16;
var CC2 = 17;
var D2 = 18;
var D3 = 19;
var FP = 20;
var E1 = 21;
var CH2 = 22;
var E2 = 23;
var E3 = 24;
var R3 = 25;
var F1 = 26;
var F2 = 27;
var U2 = 28;
var F3 = 29;
var G2J = 30;
var G1 = 31;
var G2 = 32;
var CC3 = 33;
var G3 = 34;
var R4 = 35;
var CH3 = 36;
var H1 = 37;
var T2 = 38;
var H2 = 39;

var count = Array(SQUARES + 1).join('0').split('').map(parseFloat);
var current = GO;
var double_run = 0;

for (i = 1; i <= 1e7; i++) {
    var die1 = Math.floor(Math.random() * program.sides) + 1;
    var die2 = Math.floor(Math.random() * program.sides) + 1;
    if (die1 == die2) {
        double_run++;
    } else {
        double_run = 0;
    }
    current = (current + die1 + die2) % SQUARES;

    if (double_run == 3) {
        current = JAIL;
        double_run = 0;
    }

    if (current == G2J) {
        current = JAIL;
    }

    if (current == CC1 || current == CC2 || current == CC3) {
        current = chance(current);
    }

    if (current == CH1 || current == CH2 || current == CH3) {
        current = chest(current);
    }

    count[current]++;
}

var top = Array.apply(0, Array(SQUARES)).map(function(_, i) {
    return i;
}).sort(function(a, b) {
    return count[b] - count[a];
}).slice(0, 3).map(function(square) {
    return ('00' + square).slice(-2);
}).join('');

console.log(top);

function chance(current) {
    var cc = Math.floor(Math.random() * CC_CARDS) + 1;
    if (cc == 1) {
        current = GO;
    } else if (cc == 2) {
        current = JAIL;
    }

    return current;
}

function chest(current) {
    var ch = Math.floor(Math.random() * CH_CARDS) + 1;
    if (ch == 1) {
        current = GO;
    } else if (ch == 2) {
        current = JAIL;
    } else if (ch == 3) {
        current = C1;
    } else if (ch == 4) {
        current = E3;
    } else if (ch == 5) {
        current = H2;
    } else if (ch == 6) {
        current = R1;
    } else if ((ch == 7 || ch == 8) && current == CH1) {
        current = R2;
    } else if ((ch == 7 || ch == 8) && current == CH2) {
        current = R3;
    } else if ((ch == 7 || ch == 8) && current == CH3) {
        current = R1;
    } else if (ch == 9 && (current == CH1 || current == CH3)) {
        current = U1;
    } else if (ch == 10) {
        current = (current - 3) % SQUARES;
    }

    return current;
}
