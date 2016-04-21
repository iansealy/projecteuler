#!/usr/bin/env node

// Su Doku

var SUDOKU_URL = 'https://projecteuler.net/project/resources/p096_sudoku.txt';
var LAST = 9 * 9 - 1;
var BOX_STARTS = [0, 3, 6, 27, 30, 33, 54, 57, 60];

var request = require('request');
request(SUDOKU_URL, function(error, response, body) {
    if (!error && response.statusCode == 200) {
        var rows = body.trim().split(/[\r\n]+/);
        var total = 0;
        for (var i = 0; i < 50; i++) {
            var start = i * 10 + 1;
            var sudoku = rows.slice(start, start + 9).join('').split('');
            sudoku = sudoku.map(function(digit) {
                return parseInt(digit);
            });
            sudoku = solve(sudoku);
            total += 100 * sudoku[0] + 10 * sudoku[1] + sudoku[2];
        }
        console.log(total);
    }
});

function solve(sudoku) {
    var prev_sum = 0;
    for (var i = 0; i < sudoku.length; i++) {
        prev_sum += sudoku[i];
    }
    while (true) {
        sudoku = check_candidates(sudoku);
        sudoku = find_places(sudoku);
        var new_sum = 0;
        for (var i = 0; i < sudoku.length; i++) {
            new_sum += sudoku[i];
        }
        if (prev_sum == new_sum) {
            break;
        }
        prev_sum = new_sum;
    }

    sudoku = brute_force(sudoku);

    return sudoku;
}

function check_candidates(sudoku) {
    for (var cell = 0; cell <= LAST; cell++) {
        if (sudoku[cell]) {
            continue;
        }
        var possible = get_possible(cell, sudoku);
        if (possible.length == 1) {
            sudoku[cell] = parseInt(possible[0]);
        }
    }

    return sudoku;
}

function find_places(sudoku) {
    var cells = [];

    // Columns
    var col_starts = get_row(0);
    for (var i = 0; i < col_starts.length; i++) {
        cells.push(get_col(col_starts[i]));
    }

    // Rows
    var row_starts = get_col(0);
    for (var i = 0; i < row_starts.length; i++) {
        cells.push(get_row(row_starts[i]));
    }

    // Boxes
    for (var i = 0; i < BOX_STARTS.length; i++) {
        cells.push(get_box(BOX_STARTS[i]));
    }

    for (var i = 0; i < cells.length; i++) {
        place = {};
        for (var j = 0; j < cells[i].length; j++) {
            var cell = cells[i][j];
            if (sudoku[cell]) {
                continue;
            }
            var possibles = get_possible(cell, sudoku);
            for (var k = 0; k < possibles.length; k++) {
                if (!(possibles[k] in place)) {
                    place[possibles[k]] = {};
                }
                place[possibles[k]][cell] = true;
            }
        }
        var possibles = Object.keys(place);
        for (var k = 0; k < possibles.length; k++) {
            if (Object.keys(place[possibles[k]]).length == 1) {
                var cell = Object.keys(place[possibles[k]])[0];
                sudoku[cell] = parseInt(possibles[k]);
            }
        }
    }

    return sudoku;
}

function brute_force(sudoku) {
    for (var cell = 0; cell <= LAST; cell++) {
        if (sudoku[cell]) {
            continue;
        }
        var possibles = get_possible(cell, sudoku);
        for (var k = 0; k < possibles.length; k++) {
            var candidate_sudoku = sudoku.slice();
            candidate_sudoku[cell] = parseInt(possibles[k]);
            candidate_sudoku = brute_force(candidate_sudoku);
            if (typeof candidate_sudoku != 'undefined') {
                return candidate_sudoku;
            }
        }
        return;
    }

    return sudoku;
}

function get_possible(cell, sudoku) {
    var possible = {};
    for (var i = 1; i < 10; i++) {
        possible[i] = true;
    }

    adjacent_cells = [];
    adjacent_cells = adjacent_cells.concat(get_row(cell));
    adjacent_cells = adjacent_cells.concat(get_col(cell));
    adjacent_cells = adjacent_cells.concat(get_box(cell));
    for (var i = 0; i < adjacent_cells.length; i++) {
        if (sudoku[adjacent_cells[i]]) {
            delete possible[sudoku[adjacent_cells[i]]];
        }
    }

    return Object.keys(possible).sort();
}

function get_row(cell) {
    var row_start = Math.floor(cell / 9) * 9;
    var row = [];
    for (var i = row_start; i < row_start + 9; i++) {
        row.push(i);
    }

    return row;
}

function get_col(cell) {
    var col_start = cell % 9;
    var col = [];
    for (var i = 0; i < 9; i++) {
        col.push(col_start + i * 9);
    }

    return col;
}

function get_box(cell) {
    box_start = 27 * Math.floor(cell / 27) + 3 * Math.floor((cell % 9) / 3);
    box = [];
    box = box.concat(box_start, box_start + 1, box_start + 2);
    box = box.concat(box_start + 9, box_start + 10, box_start + 11);
    box = box.concat(box_start + 18, box_start + 19, box_start + 20);

    return box;
}
