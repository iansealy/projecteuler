#!/usr/bin/env node

// Pandigital prime sets

var combinatorics = require('js-combinatorics');

var primes_for = {};
primes_for[9] = [];
for (var digits = 1; digits <= 8; digits++) {
    primes_for[digits] = [];
    var perms = combinatorics.permutation([1, 2, 3, 4, 5, 6, 7, 8, 9], digits);
    while (perm = perms.next()) {
        var num = parseInt(perm.join(''));
        if (is_prime(num)) {
            primes_for[digits].push(num);
        }
    }
    primes_for[digits] = primes_for[digits].sort();
}

console.log(sets(9, 0, []));

function sets(max_digits, length, primes) {
    var digit_seen = {};
    for (var i = 0; i < primes.length; i++) {
        var digits = primes[i].toString().split('');
        for (var j = 0; j < digits.length; j++) {
            if (digits[j] in digit_seen) {
                return 0;
            }
            digit_seen[digits[j]] = true;
        }
    }
    if (length == 9) {
        return 1;
    }

    var count = 0;
    for (var num_digits = max_digits; num_digits >= 1; num_digits--) {
        if (length + num_digits > 9) {
            continue;
        }
        for (var i = 0; i < primes_for[num_digits].length; i++) {
            var prime = primes_for[num_digits][i];
            if (primes.length && prime >= primes[primes.length - 1]) {
                break;
            }
            var new_primes = primes.slice();
            new_primes.push(prime);
            count += sets(num_digits, length + num_digits, new_primes);
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
