#!/usr/bin/env node

// Amicable numbers

var program = require('commander');

program
    .version('0.1.0')
    .description('Amicable numbers')
    .option('-l, --limit <int>', 'The maximum amicable number', Number, 10000)
    .parse(process.argv);

var sum = 0;

for (var a = 2; a < program.limit; a++) {
    var b = sum_proper_divisors(a);
    if (b > a) {
        if (sum_proper_divisors(b) == a) {
            sum += a + b;
        }
    }
}

console.log(sum);

function sum_proper_divisors(number) {
    return sum_divisors(number) - number;
}

function sum_divisors(number) {
    var divisor_sum = 1;
    var prime = 2;

    while (prime * prime <= number && number > 1) {
        if (number % prime == 0) {
            var j = prime * prime;
            number /= prime;
            while (number % prime == 0) {
                j *= prime;
                number /= prime;
            }
            divisor_sum *= (j - 1);
            divisor_sum /= (prime - 1);
        }
        if (prime == 2) {
            prime = 3;
        } else {
            prime += 2;
        }
    }
    if (number > 1) {
        divisor_sum *= (number + 1);
    }

    return divisor_sum;
}
