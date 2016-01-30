#!/usr/bin/env node

// Names scores

var NAMES_URL = 'https://projecteuler.net/project/resources/p022_names.txt';

var request = require('request');
request(NAMES_URL, function(error, response, body) {
    if (!error && response.statusCode == 200) {
        score_names(body.replace(/"/g, "").split(",").sort());
    }
});

function score_names(names) {
    var total = 0;

    for (var i = 0; i < names.length; i++) {
        var value = 0;
        for (var j = 0; j < names[i].length; j++) {
            value += names[i].charCodeAt(j) - 64;
        }
        total += (i + 1) * value;
    }

    console.log(total);
}
