# Coin sums

library(memoise)

# Constants
COINS <- c(200, 100, 50, 20, 10, 5, 2, 1)
TARGET <- 200

change <- memoise(function(money, coins) {
    if ( money < 0 ) {
        return(0)
    }
    if ( money == 0 ) {
        return(1)
    }

    count <- 0
    while ( !is.na(coins[1]) ) {
        count <- count + change(money - coins[1], coins)
        coins <- coins[2:length(coins)]
    }

    return(count)
})

cat(change(TARGET, COINS), fill=TRUE)
