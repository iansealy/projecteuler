#!/usr/bin/env node

// Special Pythagorean triplet

var SUM = 1000;

var triplet = get_pythagorean_triplet_by_sum(SUM);

console.log(triplet[0] * triplet[1] * triplet[2]);

function get_pythagorean_triplet_by_sum(target_sum) {
    var a = 1;
    while (a < target_sum - 2) {
        var b = a + 1;
        while (b < target_sum - 1) {
            var c = Math.sqrt(a * a + b * b);
            if (Math.floor(c) == c) {
                if (a + b + c == target_sum) {
                    return [a, b, c];
                }
            }
            b++;
        }
        a++;
    }
    return [0, 0, 0];
}
