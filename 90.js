#!/usr/bin/env node

// Cube digit pairs

var SQUARES = ['01', '04', '09', '16', '25', '36', '49', '64', '81'];
var DIGITS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

var distinct = 0;
var combs = combinations(DIGITS, 6);
combs = add_6_or_9(combs);
for (var i = 0; i < combs.length; i++) {
    for (var j = 0; j < combs.length; j++) {
        if (all_squares(combs[i], combs[j])) {
            distinct++;
        }
    }
}

console.log(distinct / 2);

function combinations(group, n) {
    var combs = [];

    if (n == 1) {
        for (var i = 0; i < group.length; i++) {
            combs.push([group[i]]);
        }
        return combs;
    }

    var i = 0;
    while (i + n <= group.length) {
        var next = group.slice(i, i + 1);
        var rest = group.slice(i + 1);
        var rest_combs = combinations(rest, n - 1);
        for (var j = 0; j < rest_combs.length; j++) {
            combs.push(next.concat(rest_combs[j]));
        }
        i++;
    }

    return combs;
}

function add_6_or_9(combs) {
    for (var i = 0; i < combs.length; i++) {
        var got_6 = false;
        var got_9 = false;
        for (var j = 0; j < combs[i].length; j++) {
            if (combs[i][j] == '6') {
                got_6 = true;
            } else if (combs[i][j] == '9') {
                got_9 = true;
            }
        }
        if (got_6 && !got_9) {
            combs[i].push('9');
        }
        if (got_9 && !got_6) {
            combs[i].push('6');
        }
    }

    return combs;
}

function all_squares(comb1, comb2) {
    var not_seen = {};
    for (var i = 0; i < SQUARES.length; i++) {
        not_seen[SQUARES[i]] = true;
    }

    for (var i = 0; i < comb1.length; i++) {
        for (var j = 0; j < comb2.length; j++) {
            delete not_seen[comb1[i] + comb2[j]];
            delete not_seen[comb2[j] + comb1[i]];
        }
    }

    if (Object.keys(not_seen).length) {
        return false;
    } else {
        return true;
    }
}
