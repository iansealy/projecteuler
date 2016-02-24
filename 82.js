#!/usr/bin/env node

// Path sum: three ways

var program = require('commander');

program
    .version('0.1.0')
    .description('Path sum: three ways')
    .option('-u, --url <int>', 'Matrix URL',
        'https://projecteuler.net/project/resources/p082_matrix.txt')
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
    var sum = [];
    for (var i = 0; i < rows; i++) {
        sum[i] = [];
        sum[i][0] = matrix[i][0];
    }

    for (var j = 1; j < cols; j++) {
        sum[0][j] = sum[0][j - 1] + matrix[0][j];
        for (var i = 1; i < rows; i++) {
            if (sum[i][j - 1] < sum[i - 1][j]) {
                sum[i][j] = sum[i][j - 1] + matrix[i][j];
            } else {
                sum[i][j] = sum[i - 1][j] + matrix[i][j];
            }
        }
        for (var i = rows - 2; i >= 0; i--) {
            if (sum[i][j] > sum[i + 1][j] + matrix[i][j]) {
                sum[i][j] = sum[i + 1][j] + matrix[i][j];
            }
        }
    }

    var min = sum[0][cols - 1];
    for (var i = 1; i < rows; i++) {
        if (sum[i][cols - 1] < min) {
            min = sum[i][cols - 1];
        }
    }

    console.log(min);
}
