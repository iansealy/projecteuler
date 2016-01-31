#!/usr/bin/env node

// Cyclical figurate numbers

var program = require('commander');

program
    .version('0.1.0')
    .description('Cyclical figurate numbers')
    .option('-s, --set_size <int>',
        'The number of 4-digit integers in the cyclic set', Number, 6)
    .parse(process.argv);

var functions = [
    function(n) {
        return n * (n + 1) / 2;
    },
    function(n) {
        return n * n;
    },
    function(n) {
        return n * (3 * n - 1) / 2;
    },
    function(n) {
        return n * (2 * n - 1);
    },
    function(n) {
        return n * (5 * n - 3) / 2;
    },
    function(n) {
        return n * (3 * n - 2);
    }
];

var polygonal = {};
var polygonal_type = {};
var prefix = {};
for (var type = 0; type < program.set_size; type++) {
    var n = 1;
    var p = 1;
    while (p < 10000) {
        p = functions[type](n);
        if (p >= 1000 && p < 10000) {
            polygonal[p] = true;
            if (!polygonal_type[p]) {
                polygonal_type[p] = [];
            }
            polygonal_type[p].push(type);
            var start = p.toString().substr(0, 2);
            if (!prefix[start]) {
                prefix[start] = {};
            }
            prefix[start][p] = true;
        }
        n++;
    }
}

var set_sum;
for (num in polygonal) {
    set_sum = get_cycle([num], prefix, polygonal_type, program.set_size);
    if (typeof set_sum != 'undefined') {
        break;
    }
}

console.log(set_sum);

function get_cycle(cycle, prefix, polygonal_type, set_size) {
    var set_sum;

    if (cycle.length == set_size) {
        if (cycle[0].substr(0, 2) != cycle[cycle.length - 1].substr(2, 2)) {
            return;
        }
        if (all_represented(cycle, polygonal_type, set_size)) {
            set_sum = 0;
            for (var i = 0; i < cycle.length; i++) {
                set_sum += parseInt(cycle[i]);
            }
            return set_sum;
        } else {
            return;
        }
    }

    var in_cycle = {};
    for (var i = 0; i < cycle.length; i++) {
        in_cycle[cycle[i]] = true;
    }
    var suffix = cycle[cycle.length - 1].substr(2, 2);
    var next_nums = [];
    if (typeof prefix[suffix] != 'undefined') {
        next_nums = Object.keys(prefix[suffix]);
    }
    for (var i = 0; i < next_nums.length; i++) {
        if (next_nums[i] in in_cycle) {
            continue;
        }
        var new_cycle = cycle.slice();
        new_cycle.push(next_nums[i]);
        set_sum = get_cycle(new_cycle, prefix, polygonal_type, set_size);
        if (typeof set_sum != 'undefined') {
            break;
        }
    }

    return set_sum;
}

function all_represented(cycle, polygonal_type, set_size) {
    var paths = [''];

    for (var i = 0; i < cycle.length; i++) {
        if (!polygonal_type[cycle[i]]) {
            return false;
        }
        var types = polygonal_type[cycle[i]];
        var new_paths = [];
        for (var j = 0; j < types.length; j++) {
            for (var k = 0; k < paths.length; k++) {
                new_paths.push(paths[k] + types[j].toString());
            }
        }
        paths = new_paths;
    }

    for (var i = 0; i < paths.length; i++) {
        if (unique(paths[i].split('').sort()).length == set_size) {
            return true;
        }
    }

    return false;
}

function unique(array) {
    return array.reduce(function(prev, cur) {
        if (prev.indexOf(cur) < 0) {
            prev.push(cur);
        }
        return prev;
    }, []);
}
