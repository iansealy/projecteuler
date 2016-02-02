#!/usr/bin/env node

// Powerful digit counts

var bigint = require('big-integer');

var count = 0;
var n = 0;
var match_seen = true;
while (match_seen) {
    n++;
    match_seen = false;
    var num = bigint(0);
    var power = bigint(0);
    while (power.toString().length <= n) {
        num = num.add(1);
        power = num.pow(n);
        if (power.toString().length == n) {
            count++;
            match_seen = true;
        }
    }
}

console.log(count);
