#!/usr/bin/env node

// Passcode derivation

var TRIPLETS_URL = 'https://projecteuler.net/project/resources/p079_keylog.txt';

var request = require('request');
request(TRIPLETS_URL, function(error, response, body) {
    if (!error && response.statusCode == 200) {
        get_passcode(body.trim().split(/[\r\n]+/));
    }
});

function get_passcode(triplets) {
    var after = {};
    for (var i = 0; i < triplets.length; i++) {
        var digits = triplets[i].split('');
        for (var j = 0; j < 3; j++) {
            if (!(digits[j] in after)) {
                after[digits[j]] = {};
            }
        }
        after[digits[0]][digits[1]] = true;
        after[digits[0]][digits[2]] = true;
        after[digits[1]][digits[2]] = true;
    }

    var passcode = Object.keys(after).sort(function(a, b) {
        return Object.keys(after[a]).length - Object.keys(after[b]).length;
    }).reverse().join('');

    console.log(passcode);
}
