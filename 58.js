#!/usr/bin/env node

// Spiral primes

var prime_diagonals = 0;
var total_diagonals = 0;

var width = 1;
var increment = 0;
var number = 1;

while (!total_diagonals || prime_diagonals / total_diagonals > 0.1) {
    width += 2;
    increment += 2;
    total_diagonals += 4;
    for (var i = 0; i < 4; i++) {
        number += increment;
        if (is_prime(number)) {
            prime_diagonals++;
        }
    }
}

console.log(width);

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
