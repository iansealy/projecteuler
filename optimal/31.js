#!/usr/bin/env node

// Coin sums

var TARGET = 200;
var COINS = [1, 2, 5, 10, 20, 50, 100, 200];

var ways = [1];
for (var i = 1; i <= TARGET; i++) {
    ways[i] = 0;
}

for (var i = 0; i < COINS.length; i++) {
    for (var j = COINS[i]; j <= TARGET; j++) {
        ways[j] += ways[j - COINS[i]];
    }
}

console.log(ways[TARGET]);
