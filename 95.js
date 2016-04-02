#!/usr/bin/env node

// Amicable chains

var MAX = 1000000;

var is_chain = {
    '0': 0
};

var sum_proper_divisors_for = [];

for (var num = 1; num < MAX; num++) {
    var sum = sum_proper_divisors(num);
    sum_proper_divisors_for[num] = sum;
    if (sum > MAX) {
        sum_proper_divisors_for[num] = null;
        is_chain[num] = false;
    }
}

var max_chain_length = 0;
var max_chain_min_num = 0;
for (var num = 1; num < MAX; num++) {
    if (num in is_chain && !is_chain[num]) {
        continue;
    }
    var got_chain = true;
    var chain = [num];
    var seen = {
        num: true
    };
    while (true) {
        var next_num = sum_proper_divisors_for[chain[chain.length - 1]];
        chain.push(next_num);
        if (!next_num) {
            got_chain = false;
            break;
        }
        if (chain[0] == next_num) {
            break;
        }
        if (next_num in seen) {
            got_chain = false;
            break;
        }
        seen[next_num] = true;
        if (next_num in is_chain && is_chain[next_num]) {
            got_chain = false;
            break;
        }
    }
    if (got_chain) {
        is_chain[num] = true;
        if (chain.length - 1 > max_chain_length) {
            max_chain_length = chain.length - 1;
            max_chain_min_num = num;
        }
    }
}

console.log(max_chain_min_num);

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
