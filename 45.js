#!/usr/bin/env node

// Triangular, pentagonal, and hexagonal

var functions = [
    function(n) {
        return n * (n + 1) / 2;
    },
    function(n) {
        return n * (3 * n - 1) / 2;
    },
    function(n) {
        return n * (2 * n - 1);
    }
];
var limit = 10000;
var match = [];

while (match.length <= 1) {
    limit *= 10;
    var triangles = numbers_up_to(limit, functions[0]);
    var pentagons = numbers_up_to(limit, functions[1]);
    var hexagons = numbers_up_to(limit, functions[2]);
    match = intersection(intersection(triangles, pentagons), hexagons);
}

console.log(match[1]);

function numbers_up_to(limit, func) {
    var numbers = [];
    var number = 1;
    var n = 1;
    while (number < limit) {
        n++;
        number = func(n);
        numbers.push(number);
    }
    return numbers;
}

function intersection(a, b) {
    var intersect = [];
    while (a.length && b.length) {
        if (a[0] < b[0]) {
            a.shift();
        } else if (a[0] > b[0]) {
            b.shift();
        } else {
            intersect.push(a.shift());
            b.shift();
        }
    }

    return intersect;
}
