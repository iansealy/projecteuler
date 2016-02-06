#!/usr/bin/env node

// Maximum path sum II

var TRIANGLE_URL =
    'https://projecteuler.net/project/resources/p067_triangle.txt';

var request = require('request');
request(TRIANGLE_URL, function(error, response, body) {
    if (!error && response.statusCode == 200) {
        get_max_path(body.trim().split(/[\r\n]+/));
    }
});

function get_max_path(lines) {
    // Prepare triangle
    var triangle = [];
    for (var i = 0; i < lines.length; i++) {
        var line = lines[i].split(" ");
        for (var j = 0; j < line.length; j++) {
            line[j] = parseInt(line[j]);
        }
        triangle.push(line);
    }

    for (var i = triangle.length - 2; i >= 0; i--) {
        for (var j = 0; j < triangle[i].length; j++) {
            var parent1 = triangle[i + 1][j];
            var parent2 = triangle[i + 1][j + 1];
            triangle[i][j] += parent1 > parent2 ? parent1 : parent2;
        }
    }

    console.log(triangle[0][0]);
}
