#!/usr/bin/env node

// Coin sums

var TOTAL = 200;
var COINS = [200, 100, 50, 20, 10, 5, 2, 1];

var change = (function() {
    var memo = {};

    return function(money, coins_arg) {
        var coins = coins_arg.slice();
        var key = money.toString() + ':' + coins.join(':');

        if (key in memo) {
            return memo[key];
        }

        if (money < 0) {
            memo[key] = 0;
            return 0;
        }
        if (money == 0) {
            memo[key] = 1;
            return 1;
        }

        var count = 0;
        while (coins.length) {
            var coin = coins[0];
            count += change(money - coin, coins);
            coins.shift();
        }
        memo[key] = count;
        return count;
    };
})();

console.log(change(TOTAL, COINS));
