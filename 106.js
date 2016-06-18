#!/usr/bin/env node

// Special subset sums: meta-testing

var program = require('commander');

program
    .version('0.1.0')
    .description('Special subset sums: meta-testing')
    .option('-s, --set_size <int>', 'The set size', Number, 12)
    .parse(process.argv);

var combinatorics = require('js-combinatorics');

var n = program.set_size;

var full_set = [];
for (var i = 1; i <= n; i++) {
    full_set.push(i);
}

// Make indices for subsets
var all_idxs = Array.apply(null, {
    length: n
}).map(Number.call, Number);
var subset_idxs = combinatorics.power(all_idxs).toArray();
subset_idxs.pop();
subset_idxs.shift();

// Get all subsets
var subsets = [];
var lengths = [];
for (var i = 0; i < subset_idxs.length; i++) {
    var subset = [];
    for (var j = 0; j < subset_idxs[i].length; j++) {
        subset.push(full_set[subset_idxs[i][j]]);
    }
    subsets.push(subset.sort(num_sort));
    lengths.push(subset.length);
}

var count = 0;

for (var i = 0; i < subsets.length - 1; i++) {
    var subset1 = subsets[i];
    for (var j = i + 1; j < subsets.length; j++) {
        var subset2 = subsets[j];
        if (subset1.length != subset2.length) {
            continue;
        }
        if (subset1.length == 1 && subset2.length == 1) {
            continue;
        }
        if (intersection(subsets[i], subsets[j]).length) {
            continue;
        }
        var diff = subset1.map(function(_, idx) {
            return subset1[idx] - subset2[idx];
        }).sort(num_sort);
        if (diff[0] * diff[diff.length - 1] > 0) {
            continue;
        }
        count++;
    }
}

console.log(count);

function unique(array) {
    return array.reduce(function(prev, cur) {
        if (prev.indexOf(cur) < 0) {
            prev.push(cur);
        }
        return prev;
    }, []);
}

function intersection(a, b) {
    var i = 0;
    var j = 0;
    var intersect = [];
    while (i < a.length && j < b.length) {
        if (a[i] < b[j]) {
            i++;
        } else if (a[i] > b[j]) {
            j++;
        } else {
            intersect.push(a[i]);
            i++;
            j++;
        }
    }

    return intersect;
}

function num_sort(a, b) {
    return a - b;
}
