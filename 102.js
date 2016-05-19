#!/usr/bin/env node

// Triangle containment

var URL = 'https://projecteuler.net/project/resources/p102_triangles.txt';

var request = require('request');
request(URL, function(error, response, body) {
    if (!error && response.statusCode == 200) {
        count_triangles(body.trim().split(/[\r\n]+/));
    }
});

function count_triangles(triangles) {
    var contains_origin = 0;

    for (var i = 0; i < triangles.length; i++) {
        var coords = triangles[i].split(',');
        var x1 = parseInt(coords[0]);
        var y1 = parseInt(coords[1]);
        var x2 = parseInt(coords[2]);
        var y2 = parseInt(coords[3]);
        var x3 = parseInt(coords[4]);
        var y3 = parseInt(coords[5]);
        var total_area = area(x1, y1, x2, y2, x3, y3);
        var area1 = area(0, 0, x2, y2, x3, y3);
        var area2 = area(x1, y1, 0, 0, x3, y3);
        var area3 = area(x1, y1, x2, y2, 0, 0);
        if (area1 + area2 + area3 == total_area) {
            contains_origin++;
        }
    }

    console.log(contains_origin);
}

function area(x1, y1, x2, y2, x3, y3) {
    return Math.abs(x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2) / 2);
}
