#!/usr/bin/env node

// Primes with runs

var program = require('commander');

program
    .version('0.1.0')
    .description('Primes with runs')
    .option('-n, --n <int>', 'The number of digits in the primes', Number, 10)
    .parse(process.argv);

var combinatorics = require('js-combinatorics');

var total = 0;
for (var d = 0; d < 10; d++) {
    var other_digits = [];
    for (var i = 0; i < 10; i++) {
        if (i != d) {
            other_digits.push(i);
        }
    }
    var non_rep_digits = 0;
    while (true) {
        non_rep_digits++;
        primes = [];
        var base = '';
        var indices = [];
        for (var i = 0; i < program.n; i++) {
            base += d.toString();
            indices.push(i);
        }
        var combs = combinatorics.combination(indices, non_rep_digits);
        var comb;
        while (comb = combs.next()) {
            var perms = combinatorics.baseN(other_digits, non_rep_digits);
            var perm;
            while (perm = perms.next()) {
                var num = base;
                for (var i = 0; i < non_rep_digits; i++) {
                    num = num.substr(0, comb[i]) + perm[i].toString() +
                        num.substr(comb[i] + 1);
                }
                if (num.substr(0, 1) == '0') {
                    continue;
                }
                num = parseInt(num);
                if (is_prime(num)) {
                    primes.push(num);
                    total += num;
                }
            }
        }
        if (primes.length) {
            break;
        }
    }
}

console.log(total);

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
