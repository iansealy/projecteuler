#!/usr/bin/env node

// Pentagon numbers

var is_pentagonal = {
    1: 1
};
var pentagons = [1];
var diff;
var n = 1;
while (typeof diff == 'undefined') {
    n++;
    var next = n * (3 * n - 1) / 2;
    for (var i = 0; i < pentagons.length; i++) {
        var candidate = next - pentagons[i];
        if (is_pentagonal[candidate] &&
            is_pentagonal[Math.abs(pentagons[i] - candidate)]) {
            diff = Math.abs(pentagons[i] - candidate);
        }
    }
    pentagons.unshift(next);
    is_pentagonal[next] = true;
}

console.log(diff);
