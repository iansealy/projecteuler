#!/usr/bin/env node

// Path sum: four ways

var program = require('commander');

program
    .version('0.1.0')
    .description('Path sum: four ways')
    .option('-u, --url <URL>', 'Matrix URL',
        'https://projecteuler.net/project/resources/p083_matrix.txt')
    .parse(process.argv);

var request = require('request');
request(program.url, function(error, response, body) {
    if (!error && response.statusCode == 200) {
        var matrix = [];
        var rows = body.trim().replace(/"/g, "").split(/[\r\n]+/);
        for (var i = 0; i < rows.length; i++) {
            matrix.push(rows[i].split(',').map(Number));
        }
        sum_path(matrix);
    }
});

function sum_path(matrix) {
    var rows = matrix.length;
    var cols = matrix[0].length;

    // Label nodes
    var node = [];
    var label = 0;
    for (var i = 0; i < rows; i++) {
        node[i] = [];
        for (var j = 0; j < cols; j++) {
            label++;
            node[i][j] = label;
        }
    }

    // Make graph
    var graph = {};

    // Up
    for (var i = 1; i < rows; i++) {
        for (var j = 0; j < cols; j++) {
            if (!(node[i][j] in graph)) {
                graph[node[i][j]] = {};
            }
            graph[node[i][j]][node[i - 1][j]] = matrix[i - 1][j];
        }
    }

    // Down
    for (var i = 0; i < rows - 1; i++) {
        for (var j = 0; j < cols; j++) {
            if (!(node[i][j] in graph)) {
                graph[node[i][j]] = {};
            }
            graph[node[i][j]][node[i + 1][j]] = matrix[i + 1][j];
        }
    }

    // Left
    for (var i = 0; i < rows; i++) {
        for (var j = 1; j < cols; j++) {
            if (!(node[i][j] in graph)) {
                graph[node[i][j]] = {};
            }
            graph[node[i][j]][node[i][j - 1]] = matrix[i][j - 1];
        }
    }

    // Right
    for (var i = 0; i < rows; i++) {
        for (var j = 0; j < cols - 1; j++) {
            if (!(node[i][j] in graph)) {
                graph[node[i][j]] = {};
            }
            graph[node[i][j]][node[i][j + 1]] = matrix[i][j + 1];
        }
    }

    // Dijkstra
    node = 1;
    var destination = rows * cols;
    var unvisited = {};
    for (var i = 2; i <= destination; i++) {
        unvisited[i] = true;
    }
    var distance = {};
    distance[node] = matrix[0][0];
    while (destination in unvisited) {
        var next_nodes = Object.keys(graph[node]);
        for (var i = 0; i < next_nodes.length; i++) {
            if (!(next_nodes[i] in distance) ||
                distance[next_nodes[i]] >
                distance[node] + graph[node][next_nodes[i]]) {
                distance[next_nodes[i]] =
                    distance[node] + graph[node][next_nodes[i]];
            }
        }
        delete unvisited[node];
        var candidates = Object.keys(unvisited);
        var min_distance = undefined;
        for (var i = 0; i < candidates.length; i++) {
            if (candidates[i] in distance) {
                if (typeof min_distance == 'undefined' ||
                    distance[candidates[i]] < min_distance) {
                    node = candidates[i];
                    min_distance = distance[candidates[i]];
                }
            }
        }
    }

    console.log(distance[destination]);
}
