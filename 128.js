#!/usr/bin/env node

// Hexagonal tile differences

var program = require('commander');

program
    .version('0.1.0')
    .description('Hexagonal tile differences')
    .option('-o, --ordinal <int>',
        'The required ordinal of the sequence', Number, 2000)
    .parse(process.argv);

var tile;
var ring = 1;
var count = 2; // # PD(1) = 3 & PD(2) = 3
while (true) {
    ring++;
    var neighbours = [];

    // Top tile
    var tile = top(ring);
    neighbours = [
        top(ring + 1),
        top(ring + 1) + 1,
        top(ring) + 1,
        top(ring - 1),
        top(ring + 1) - 1,
        top(ring + 2) - 1
    ];
    count += pd(tile, neighbours) == 3;
    if (count == program.ordinal) {
        break;
    }

    // Top tile
    var tile = top(ring + 1) - 1;
    neighbours = [
        top(ring + 2) - 1,
        top(ring),
        top(ring - 1),
        top(ring) - 1,
        top(ring + 1) - 2,
        top(ring + 2) - 2
    ];
    count += pd(tile, neighbours) == 3;
    if (count == program.ordinal) {
        break;
    }
}

console.log(tile);

function top(ring) {
    return 3 * ring * ring - 3 * ring + 2;
}

function pd(centre, neighbours) {
    var count = 0;
    for (var i = 0; i < neighbours.length; i++) {
        var diff = Math.abs(centre - neighbours[i]);
        if (is_prime(diff)) {
            count++;
        }
    }

    return count;
}

function is_prime(num) {
    if (num == 1) {
        return false; // 1 isn't prime
    } else if (num < 4) {
        return true; // 2 and 3 are prime
    } else if (num % 2 == 0) {
        return false; // Even numbers aren't prime
    } else if (num < 9) {
        return true; // 5 and 7 are prime
    } else if (num % 3 == 0) {
        return false; // Numbers divisible by three aren't prime
    }

    var num_sqrt = Math.floor(Math.sqrt(num));
    var factor = 5;
    while (factor <= num_sqrt) {
        if (num % factor == 0) {
            return false; // Primes greater than 3 are 6k - 1
        } else if (num % (factor + 2) == 0) {
            return false; // Or 6k + 1
        }
        factor += 6;
    }

    return true;
}
