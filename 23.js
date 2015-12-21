#!/usr/bin/env node

// Non-abundant sums

var HIGHEST_ABUNDANT_SUM = 28123;

var abundant_numbers = [];
for (var i = 1; i <= HIGHEST_ABUNDANT_SUM; i++) {
    if (sum_proper_divisors(i) > i) {
        abundant_numbers.push(i);
    }
}

var abundant_sums = [];
for (var i = 0; i < abundant_numbers.length; i++) {
    for (var j = 0; j < abundant_numbers.length; j++) {
        abundant_sums[abundant_numbers[i] + abundant_numbers[j]] = true;
    }
}

var sum = 0;
for (var i = 1; i <= HIGHEST_ABUNDANT_SUM; i++) {
    if (!abundant_sums[i]) {
        sum += i;
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
