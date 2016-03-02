# Coin partitions

library(memoise)

Args    <- commandArgs()
divisor <- ifelse(is.na(Args[6]), 1e6, as.numeric(Args[6]))

partitions <- memoise(function(n) {
    if ( n == 0 ) {
        return(1)
    }

    parts <- 0
    k <- 1
    while ( TRUE ) {
        pent <- pentagonal(k)
        if ( n - pent < 0 ) {
            break
        }
        parts <- parts + (-1) ^ (k - 1) * partitions(n - pent)
        parts <- parts %% divisor
        if (k > 0) {
            k <- -k
        } else {
            k <- -k + 1
        }
    }

    return(parts)
})

pentagonal <- memoise(function(n) {
    return((3 * n * n - n) / 2)
})

n <- 1
while ( partitions(n) ) {
    n <- n + 1
}

cat(n, fill=TRUE)
