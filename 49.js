#!/usr/bin/env node

// Prime permutations

var KNOWN = '148748178147';

var primes = get_primes_up_to(9999);
primes = primes.filter(function(n) {
    return n > 1000
});

var perm_groups = {};
for (var i = 0; i < primes.length; i++) {
    var digits = primes[i].toString().split('');
    digits.sort();
    var ordered_digits = digits.join('');
    if (!perm_groups[ordered_digits]) {
        perm_groups[ordered_digits] = [];
    }
    perm_groups[ordered_digits].push(primes[i]);
}

var groups = [];
for (var group in perm_groups) {
    if (perm_groups[group].length >= 3) {
        groups.push(perm_groups[group]);
    }
}

var output;
for (var i = 0; i < groups.length; i++) {
    var group3s = combinations(groups[i], 3);
    for (var j = 0; j < group3s.length; j++) {
        if (group3s[j][1] - group3s[j][0] == group3s[j][2] - group3s[j][1]) {
            var concat = group3s[j].join('');
            if (concat != KNOWN) {
                output = concat;
            }
        }
    }
}

console.log(output);

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

function combinations(group, n) {
    var combs = [];

    if (n == 1) {
        for (var i = 0; i < group.length; i++) {
            combs.push([group[i]]);
        }
        return combs;
    }

    var i = 0;
    while (i + n <= group.length) {
        var next = group.slice(i, i + 1);
        var rest = group.slice(i + 1);
        var rest_combs = combinations(rest, n - 1);
        for (var j = 0; j < rest_combs.length; j++) {
            combs.push(next.concat(rest_combs[j]));
        }
        i++;
    }

    return combs;
}
