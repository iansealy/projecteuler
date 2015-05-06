# Coin sums

library(memoise)

# Constants
COINS <- c(1, 2, 5, 10, 20, 50, 100, 200)
TARGET <- 200

ways <- vector(mode="integer", length=TARGET + 1)
ways[1] = 1

for ( coin in COINS ) {
    for ( i in seq.int(coin + 1, TARGET + 2) ) {
        ways[i] <- ways[i] + ways[i - coin]
    }
}

cat(ways[TARGET + 1], fill=TRUE)
