# Distinct primes factors

Args  <- commandArgs()
target <- ifelse(is.na(Args[6]), 4, as.numeric(Args[6]))

limit <- 100
first <- NA
while ( is.na(first) ) {
    limit <- limit * 10
    sieve <- rep(0, limit)
    consecutive <- 0
    i <- 1
    while ( i < limit ) {
        i <- i + 1
        if ( !sieve[i - 1] ) {
            j <- 2 * i
            while ( j <= limit ) {
                sieve[j - 1] <- sieve[j - 1] + 1
                j <- j + i
            }
        }
        if ( sieve[i - 1] == target ) {
            consecutive <- consecutive + 1
            if ( consecutive == target ) {
                first <- i - target + 1
                break
            }
        } else {
            consecutive <- 0
        }
    }
}

cat(first, fill=TRUE)
