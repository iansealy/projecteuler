#!/usr/bin/env node

// Prime summations

var program = require('commander');

program
    .version('0.1.0')
    .description('Prime summations')
    .option('-m, --minimum <int>',
        'The minimum number of prime sums', Number, 5001)
    .parse(process.argv);

var ways = (function() {
    var memo = {};

    return function(total, numbers_arg) {
        var numbers = numbers_arg.slice();
        var key = total.toString() + ':' + numbers.join(':');

        if (key in memo) {
            return memo[key];
        }

        if (total < 0) {
            memo[key] = 0;
            return 0;
        }
        if (total == 0) {
            memo[key] = 1;
            return 1;
        }

        var count = 0;
        while (numbers.length) {
            var number = numbers[0];
            count += ways(total - number, numbers);
            numbers.shift();
        }
        memo[key] = count;
        return count;
    };
})();

var n = 0;
var prime_limit = 1;
var num_ways = 0;
var primes = [];
while (num_ways < program.minimum) {
    n++;
    if (n == prime_limit) {
        primes = get_primes_up_to(n * 10);
        prime_limit = n * 10;
    }
    num_ways = ways(n, primes.filter(function(prime) {
        return prime < n;
    }));
}

console.log(n);

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
