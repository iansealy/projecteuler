#!/usr/bin/env node

// Roman numerals

var ROMAN_URL = 'https://projecteuler.net/project/resources/p089_roman.txt';
var TO_DECIMAL = {
    'I': 1,
    'V': 5,
    'X': 10,
    'L': 50,
    'C': 100,
    'D': 500,
    'M': 1000
};
var TO_ROMAN = [
    [1000, 'M'],
    [900, 'CM'],
    [500, 'D'],
    [400, 'CD'],
    [100, 'C'],
    [90, 'XC'],
    [50, 'L'],
    [40, 'XL'],
    [10, 'X'],
    [9, 'IX'],
    [5, 'V'],
    [4, 'IV'],
    [1, 'I']
];

var request = require('request');
request(ROMAN_URL, function(error, response, body) {
    if (!error && response.statusCode == 200) {
        reduce_numerals(body.trim().split(/[\r\n]+/));
    }
});

function reduce_numerals(non_minimal_nums) {
    var minimal_length = 0;
    var non_minimal_length = 0;
    for (var i = 0; i < non_minimal_nums.length; i++) {
        non_minimal_length += non_minimal_nums[i].toString().length;
        var minimal_num = to_roman(to_decimal(non_minimal_nums[i]));
        minimal_length += minimal_num.toString().length;
    }

    console.log(non_minimal_length - minimal_length);
}

function to_decimal(roman) {
    var decimal = 0;

    while (roman.length) {
        if (/^(IV|IX|XL|XC|CD|CM)/.test(roman)) {
            var num1 = roman.substring(0, 1);
            var num2 = roman.substring(1, 2);
            roman = roman.substring(2);
            decimal += TO_DECIMAL[num2] - TO_DECIMAL[num1];
        } else {
            var num = roman.substring(0, 1);
            roman = roman.substring(1);
            decimal += TO_DECIMAL[num];
        }
    }

    return decimal;
}

function to_roman(decimal) {
    var roman = '';

    for (var i = 0; i < TO_ROMAN.length; i++) {
        var quotient = Math.floor(decimal / TO_ROMAN[i][0]);
        for (var j = 0; j < quotient; j++) {
            roman += TO_ROMAN[i][1];
        }
        decimal = decimal % TO_ROMAN[i][0];
    }

    return roman;
}
