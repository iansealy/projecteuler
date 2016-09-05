#!/usr/bin/env node

// Efficient exponentiation

var program = require('commander');

program
    .version('0.1.0')
    .description('Efficient exponentiation')
    .option('-l, --limit <int>', 'The maximum value of k', Number, 200)
    .parse(process.argv);

var sum = require('compute-sum');

var multis = make_tree(1, 0, [], [0], program.limit);

console.log(sum(multis));

function make_tree(exponent, depth, tree, multis, limit) {
    if (exponent > limit) {
        return multis;
    }
    if (multis.length >= exponent && depth > multis[exponent]) {
        return multis;
    }

    multis[exponent] = depth;
    tree[depth] = exponent;

    for (var prev_depth = depth; prev_depth >= 0; prev_depth--) {
        make_tree(exponent + tree[prev_depth], depth + 1, tree, multis, limit);
    }

    return multis;
}
