#!/usr/bin/env node

// Special subset sums: testing

var SETS_URL = 'https://projecteuler.net/project/resources/p105_sets.txt';

var combinatorics = require('js-combinatorics');

var sum = require('compute-sum');

var request = require('request');
request(SETS_URL, function(error, response, body) {
    if (!error && response.statusCode == 200) {
        sum_special_sum_sets(body.trim().split(/[\r\n]+/));
    }
});

function sum_special_sum_sets(sets) {
    var total = 0;
    for (var i = 0; i < sets.length; i++) {
        var set = sets[i].split(',').map(function(num) {
            return parseInt(num);
        });
        if (is_special_sum_set(set)) {
            total += sum(set);
        }
    }

    console.log(total);
}

function is_special_sum_set(set) {
    var n = set.length;

    // Make indices for subsets
    var all_idxs = Array.apply(null, {
        length: n
    }).map(Number.call, Number);
    var subset_idxs = combinatorics.power(all_idxs).toArray();
    subset_idxs.pop();
    subset_idxs.shift();

    // Get all subsets
    var subsets = [];
    var sums = [];
    var lengths = [];
    for (var i = 0; i < subset_idxs.length; i++) {
        var subset = [];
        for (var j = 0; j < subset_idxs[i].length; j++) {
            subset.push(set[subset_idxs[i][j]]);
        }
        subsets.push(subset.sort(num_sort));
        sums.push(sum(subset));
        lengths.push(subset.length);
    }

    // Check for disjoint subsets with equal sums
    var uniq_sums = unique(sums);
    for (var i = 0; i < uniq_sums.length; i++) {
        var indices = [];
        for (var j = 0; j < sums.length; j++) {
            if (sums[j] == uniq_sums[i]) {
                indices.push(j);
            }
        }
        if (indices.length == 1) {
            continue;
        }
        var pair_iterator = combinatorics.combination(indices, 2);
        var pair;
        while (pair = pair_iterator.next()) {
            if (!intersection(subsets[pair[0]], subsets[pair[1]]).length) {
                return false;
            }
        }
    }

    // Check for disjoint subsets of different lengths and sums
    var indices = Array.apply(null, {
        length: subsets.length
    }).map(Number.call, Number);
    for (var i = 0; i < subsets.length; i++) {
        for (var j = 0; j < subsets.length; j++) {
            if (lengths[i] < lengths[j] && sums[i] > sums[j] &&
                !intersection(subsets[i], subsets[j]).length) {
                return false;
            }
        }
    }

    return true;
}

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
