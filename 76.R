# Counting summations

library(memoise)

Args   <- commandArgs()
number <- ifelse(is.na(Args[6]), 100, as.numeric(Args[6]))

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

cat(partitions(number) - 1, fill=TRUE)
