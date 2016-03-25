#!/usr/bin/env node

// Arithmetic expressions

var program = require('commander');

program
    .version('0.1.0')
    .description('Arithmetic expressions')
    .option('-m, --max_digit <int>', 'The highest digit', Number, 9)
    .parse(process.argv);

var combinatorics = require('js-combinatorics');

var operators = [
    function(n1, n2) {
        return n1 + n2;
    },
    function(n1, n2) {
        return n1 - n2;
    },
    function(n1, n2) {
        return n1 * n2;
    },
    function(n1, n2) {
        if (!n2) {
            return 0;
        }
        return n1 / n2;
    }
];

var ops = [0, 1, 2, 3];
var op_perms = combinatorics.cartesianProduct(ops, ops, ops).toArray();
var order_perms = combinatorics.permutation([1, 2, 3], 3).toArray();

var max_digits;
var max_consec = 0;
var digits = [];
for (var i = 1; i <= program.max_digit; i++) {
    digits.push(i);
}
var digit_combs = combinatorics.combination(digits, 4);
var digit_comb;
while (digit_comb = digit_combs.next()) {
    var seen = [];
    var digit_perms = combinatorics.permutation(digit_comb, 4);
    while (digit_perm = digit_perms.next()) {
        for (var i = 0; i < op_perms.length; i++) {
            for (var j = 0; j < order_perms.length; j++) {
                var nums = digit_perm.slice();
                var ops = op_perms[i].slice();
                var order = order_perms[j].slice();
                while (order.length) {
                    var ordinal = order.shift();
                    var num1 = nums.slice(ordinal - 1, ordinal)[0];
                    var num2 = nums.slice(ordinal, ordinal + 1)[0];
                    var op = ops.splice(ordinal - 1, 1);
                    nums.splice(ordinal - 1, 2, operators[op](num1, num2));
                    order = order.map(function(n) {
                        if (n > ordinal) {
                            return n - 1;
                        } else {
                            return n;
                        }
                    });
                }
                var num = nums.shift();
                if (Math.floor(num) != num || num < 1) {
                    continue;
                }
                seen[num] = true;
            }
        }
    }
    var consec = 0;
    while (seen[consec + 1]) {
        consec++;
    }
    if (consec > max_consec) {
        max_consec = consec;
        max_digits = digit_comb.sort().join('');
    }
}

console.log(max_digits);
