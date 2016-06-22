#!/usr/bin/env node

// Minimal network

var NETWORK_URL = 'https://projecteuler.net/project/resources/p107_network.txt';

var request = require('request');
request(NETWORK_URL, function(error, response, body) {
    if (!error && response.statusCode == 200) {
        minimal_network(body.trim().split(/[\r\n]+/));
    }
});

function minimal_network(matrix) {
    var num_vertices = matrix.length;
    var edges = [];
    var total_weight = 0;
    for (var i = 1; i < matrix.length; i++) {
        var weights = matrix[i - 1].split(',');
        for (var j = i + 1; j <= weights.length; j++) {
            if (weights[j - 1] != '-') {
                total_weight += parseInt(weights[j - 1])
                edges.push([parseInt(weights[j - 1]), i, j]);
            }
        }
    }
    edges = edges.sort(num_sort_first);

    var graph = {};
    var minimum_weight = 0;
    for (var i = 0; i < edges.length; i++) {
        var weight = edges[i][0];
        var node1 = edges[i][1];
        var node2 = edges[i][2];

        var undiscovered = {};
        for (var j = 1; j <= num_vertices; j++) {
            undiscovered[j] = true;
        }
        var s = [node1];
        while (s.length) {
            var v = s.pop();
            if (v in undiscovered) {
                delete undiscovered[v];
                if (v in graph) {
                    var nodes = Object.keys(graph[v]);
                    for (var j = 0; j <= nodes.length; j++) {
                        s.push(nodes[j]);
                    }
                }
            }
        }
        if (node2 in undiscovered) {
            if (!(node1 in graph)) {
                graph[node1] = {};
            }
            graph[node1][node2] = weight;
            if (!(node2 in graph)) {
                graph[node2] = {};
            }
            graph[node2][node1] = weight;
            minimum_weight += weight;
        }
    }

    console.log(total_weight - minimum_weight);
}

function num_sort_first(a, b) {
    return a[0] - b[0];
}
