#!/usr/bin/env node

// Palindromic sums

var program = require('commander');

program
    .version('0.1.0')
    .description('Palindromic sums')
    .option('-l, --limit <int>', 'The maximum number', Number, 1e8)
    .parse(process.argv);

var squares = [1];
var n = 1;
while (squares[squares.length - 1] < program.limit) {
    n++;
    squares.push(n * n);
}

var palindrome = {};

for (var start = 1; start <= squares.length - 1; start++) {
    var square_sum = squares[start - 1];
    var next = start + 1;
    while (next < squares.length) {
        square_sum += squares[next - 1];
        if (square_sum > program.limit) {
            break;
        }
        if (is_palindrome(square_sum)) {
            palindrome[square_sum] = true;
        }
        next++;
    }
}

var total = 0;
for (num in palindrome) {
    total += parseInt(num);
}

console.log(total);

function is_palindrome(number) {
    return number.toString().split('').reverse('').join('') == number;
}
