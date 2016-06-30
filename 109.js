#!/usr/bin/env node

// Darts

var MAX = 100;
var UPPER = 170;

var doubles = [];
var all = [];
for (var i = 1; i <= 20; i++) {
    doubles.push(i * 2);
    all = all.concat([i, i * 2, i * 3]);
}
doubles.push(50);
all = all.concat(25, 50).sort(num_sort);

var ways = Array.apply(null, Array(UPPER + 1)).map(Number.prototype.valueOf, 0);

// One dart
for (var k = 0; k < doubles.length; k++) {
    ways[doubles[k]]++;
}

// Two darts
for (var i = 0; i < all.length; i++) {
    for (var k = 0; k < doubles.length; k++) {
        ways[all[i] + doubles[k]]++;
    }
}

// Three darts
for (var i = 0; i < all.length; i++) {
    for (var j = i; j < all.length; j++) {
        for (var k = 0; k < doubles.length; k++) {
            ways[all[i] + all[j] + doubles[k]]++;
        }
    }
}

var total = 0;
for (var i = 1; i < MAX; i++) {
    total += ways[i];
}
console.log(total);

function num_sort(a, b) {
    return a - b;
}
