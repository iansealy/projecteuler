#!/usr/bin/env node

// Path sum: two ways

var program = require('commander');

program
    .version('0.1.0')
    .description('Path sum: two ways')
    .option('-u, --url <int>', 'Matrix URL',
        'https://projecteuler.net/project/resources/p081_matrix.txt')
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
    for (var i = 0; i <= rows; i++) {
        sum[i] = [];
        for (var j = 0; j <= cols; j++) {
            sum[i][j] = undefined;
        }
    }
    sum[1][0] = 0;
    sum[0][1] = 0;

    for (var i = 1; i <= rows; i++) {
        for (var j = 1; j <= cols; j++) {
            sum[i][j] = matrix[i - 1][j - 1];
            if (typeof sum[i - 1][j] == 'undefined') {
                sum[i][j] += sum[i][j - 1];
            } else if (typeof sum[i][j - 1] == 'undefined') {
                sum[i][j] += sum[i - 1][j];
            } else if (sum[i - 1][j] < sum[i][j - 1]) {
                sum[i][j] += sum[i - 1][j];
            } else {
                sum[i][j] += sum[i][j - 1];
            }
        }
    }

    console.log(sum[rows][cols]);
}
