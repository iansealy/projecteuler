#!/usr/bin/env node

// Special Pythagorean triplet

var SUM = 1000;

var triplet = get_pythagorean_triplet_by_sum(SUM);

console.log(triplet[0] * triplet[1] * triplet[2]);

function get_pythagorean_triplet_by_sum(s) {
    var s2 = Math.floor(SUM / 2);
    var mlimit = Math.ceil(Math.sqrt(s2)) - 1;
    for (var m = 2; m <= mlimit; m++) {
        if (s2 % m == 0) {
            var sm = Math.floor(s2 / m);
            while (sm % 2 == 0) {
                sm = Math.floor(sm / 2);
            }
            var k = m + 1;
            if (m % 2 == 1) {
                k = m + 2;
            }
            while (k < 2 * m && k <= sm) {
                if (sm % k == 0 && gcd(k, m) == 1) {
                    var d = Math.floor(s2 / (k * m));
                    var n = k - m;
                    var a = d * (m * m - n * n);
                    var b = 2 * d * m * n;
                    var c = d * (m * m + n * n);
                    return [a, b, c];
                }
                k += 2;
            }
        }
    }

    return [0, 0, 0];
}

function gcd(int1, int2) {
    if (int1 > int2) {
        var tmp = int1;
        int1 = int2;
        int2 = tmp;
    }

    while (int1) {
        var tmp = int1;
        int1 = int2 % int1;
        int2 = tmp;
    }

    return int2;
}
