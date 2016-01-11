#!/usr/bin/env node

// Coded triangle numbers

var WORDS_URL = 'https://projecteuler.net/project/resources/p042_words.txt';

var request = require('request');
request(WORDS_URL, function(error, response, body) {
    if (!error && response.statusCode == 200) {
        count_triangles(body.replace(/"/g, "").split(","));
    }
});

function count_triangles(words) {
    var is_triangle = {};
    var n = 1;
    var triangle = 0;
    while (triangle < 1000) {
        triangle = n * (n + 1) / 2;
        is_triangle[triangle] = true;
        n++;
    }

    var count = 0;
    for (var i = 0; i < words.length; i++) {
        var value = 0;
        for (var j = 0; j < words[i].length; j++) {
            value += words[i].charCodeAt(j) - 64;
        }
        if (is_triangle[value]) {
            count++;
        }
    }

    console.log(count);
}
