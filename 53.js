#!/usr/bin/env node

// Combinatoric selections

var N = 100;

var factorial_digits = get_factorial_digits(N);

var greater_count = 0;
for (var n = 1; n <= N; n++) {
    for (var r = 1; r <= n; r++) {
        var comb_digits = factorial_digits[n] - factorial_digits[r] -
            factorial_digits[n - r];
        if (comb_digits >= 7) {
            greater_count++;
        } else if (comb_digits >= 5) {
            var comb = 1;
            for (var i = r + 1; i <= n; i++) {
                comb *= i;
            }
            for (var i = 2; i <= n - r; i++) {
                comb /= i;
            }
            if (comb > 1000000) {
                greater_count++;
            }
        }
    }
}

console.log(greater_count);

function get_factorial_digits(limit) {
    var factorials = [1];

    var digits = [1];
    for (var num = 1; num <= limit; num++) {
        var new_digits = [];
        var carry = 0;
        for (var i = 0; i < digits.length; i++) {
            var product = digits[i] * num + (carry || 0);
            var last_digit_of_product = parseInt(product.toString().slice(-1));
            new_digits.push(last_digit_of_product);
            carry = parseInt(product.toString().slice(0, -1));
        }
        if (carry) {
            var carry_digits = carry.toString().split("").reverse();
            for (var i = 0; i < carry_digits.length; i++) {
                new_digits.push(parseInt(carry_digits[i]));
            }
        }
        factorials.push(new_digits.length);
        digits = new_digits;
    }

    return factorials;
}
