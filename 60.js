#!/usr/bin/env node

// Prime pair sets

var program = require('commander');

program
    .version('0.1.0')
    .description('Prime pair sets')
    .option('-s, --set_size <int>', 'The target number of primes in the set',
        Number, 5)
    .parse(process.argv);

var limit = 10;
var min_set_sum = limit * limit;

while (min_set_sum == limit * limit) {
    limit *= 10;
    min_set_sum = limit * limit;

    var primes = get_primes_up_to(limit);

    var pair = {};
    for (var i = 0; i < primes.length; i++) {
        for (var j = 0; j < primes.length; j++) {
            if (primes[j] <= primes[i]) {
                continue;
            }
            var pair1 = parseInt(primes[i].toString() + primes[j].toString());
            var pair2 = parseInt(primes[j].toString() + primes[i].toString());
            if (is_prime(pair1) && is_prime(pair2)) {
                if (!pair[primes[i]]) {
                    pair[primes[i]] = {};
                }
                pair[primes[i]][primes[j]] = true;
            }
        }
    }

    primes = Object.keys(pair).map(function(prime) {
        return parseInt(prime);
    }).sort(num_sort);
    for (var i = 0; i < primes.length; i++) {
        if (primes[i] > min_set_sum) {
            break;
        }
        var candidates = Object.keys(pair[primes[i]]).map(function(prime) {
            return parseInt(prime);
        }).sort(num_sort);
        min_set_sum = get_set(pair, candidates, [primes[i]], program.set_size,
            min_set_sum);
    }
}

console.log(min_set_sum);

function get_set(pair, candidates, set, set_size, min_set_sum) {
    var set_sum = 0;
    for (var i = 0; i < set.length; i++) {
        set_sum += set[i];
    }

    if (set.length == set_size) {
        return set_sum < min_set_sum ? set_sum : min_set_sum;
    }

    for (var i = 0; i < candidates.length; i++) {
        if (set_sum + candidates[i] > min_set_sum) {
            return min_set_sum;
        }
        var new_candidates = [];
        if (typeof pair[candidates[i]] != 'undefined') {
            new_candidates = Object.keys(pair[candidates[i]]).sort(num_sort);
        }
        new_candidates = intersection(candidates, new_candidates);
        var new_set = set.slice();
        new_set.push(candidates[i]);
        min_set_sum = get_set(pair, new_candidates, new_set, set_size,
            min_set_sum);
    }

    return min_set_sum;
}

function num_sort(a, b) {
    return a - b;
}

function intersection(a, b) {
    var i = 0;
    var j = 0;
    var intersect = [];
    while (i < a.length && j < b.length) {
        if (a[i] < b[j]) {
            i++;
        } else if (a[i] > b[j]) {
            j++;
        } else {
            intersect.push(a[i]);
            i++;
            j++;
        }
    }

    return intersect;
}

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
