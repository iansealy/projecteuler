#!/usr/bin/env node

// Counting rectangles

var TARGET = 2000000;

// Get triangular numbers
var triangle = [0];
var n = 0;
while (triangle[triangle.length - 1] < TARGET) {
    n++;
    triangle.push(n * (n + 1) / 2);
}

var closest_area;
var closest_diff = TARGET;
for (var i = 1; i < triangle.length; i++) {
    for (var j = i; j < triangle.length; j++) {
        var rectangles = triangle[i] * triangle[j];
        if (Math.abs(rectangles - TARGET) < closest_diff) {
            closest_diff = Math.abs(rectangles - TARGET);
            closest_area = i * j;
        }
    }
}

console.log(closest_area);
