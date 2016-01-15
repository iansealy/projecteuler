#!/usr/bin/env node

// Goldbach's other conjecture

var limit = 100;
var smallest;

while (typeof smallest == 'undefined') {
    limit *= 10;
    primes = get_primes_up_to(limit);
    is_prime = {};
    for (var i = 0; i < primes.length; i++) {
        is_prime[primes[i]] = true;
    }
    twice_squares = get_twice_squares_up_to(limit);
    is_twice_square = {};
    for (var i = 0; i < twice_squares.length; i++) {
        is_twice_square[twice_squares[i]] = true;
    }
    var n = 1;
    while (n < limit) {
        n += 2;
        if (is_prime[n]) {
            continue;
        }
        var is_prime_plus_twice_square = false;
        for (var i = 0; i < primes.length; i++) {
            if (primes[i] >= n) {
                break;
            }
            if (is_twice_square[n - primes[i]]) {
                is_prime_plus_twice_square = true;
                break;
            }
        }
        if (!is_prime_plus_twice_square) {
            smallest = n;
            break;
        }
    }
}

console.log(smallest);

function get_primes_up_to(limit) {
    var sieve_bound = Math.floor((limit - 1) / 2); // Last index of sieve
    var sieve = [];
    var cross_limit = Math.floor((Math.floor(Math.sqrt(limit)) - 1) / 2);
    for (var i = 1; i <= cross_limit; i++) {
        if (!sieve[i - 1]) {
            // 2 * i + 1 is prime, so mark multiples
            var j = 2 * i * (i + 1);
            while (j <= sieve_bound) {
                sieve[j - 1] = true;
                j += 2 * i + 1;
            }
        }
    }

    var primes = [2];
    for (var i = 1; i <= sieve_bound; i++) {
        if (!sieve[i - 1]) {
            primes.push(2 * i + 1);
        }
    }

    return primes;
}

function get_twice_squares_up_to(limit) {
    var twice_squares = [2];
    var i = 1;
    while (twice_squares[twice_squares.length - 1] < limit) {
        i++;
        twice_squares.push(2 * i * i);
    }

    return twice_squares;
}
