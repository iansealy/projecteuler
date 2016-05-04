#!/usr/bin/env node

// Largest exponential

var EXP_URL = 'https://projecteuler.net/project/resources/p099_base_exp.txt';

var request = require('request');
request(EXP_URL, function(error, response, body) {
    if (!error && response.statusCode == 200) {
        largest_exponential(body.trim().split(/[\r\n]+/));
    }
});

function largest_exponential(pairs) {
    var max_num = 0;
    var max_line = 0;
    var line = 0;
    for (var i = 0; i < pairs.length; i++) {
        line++;
        var pair = pairs[i].split(',');
        var num = parseInt(pair[1]) * Math.log(parseInt(pair[0]));
        if (num > max_num) {
            max_num = num;
            max_line = line;
        }
    }

    console.log(max_line);
}
