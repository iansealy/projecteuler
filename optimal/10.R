# Summation of primes

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 2000000, as.numeric(Args[6]))

sieve_bound <- (limit - 1) %/% 2 # Last index of sieve
sieve <- rep(FALSE, sieve_bound)
cross_limit <- (floor(sqrt(limit)) - 1) %/% 2

i <- 1
while ( i <= cross_limit ) {
    if ( !sieve[i] ) {
        # 2 * $i + 1 is prime, so mark multiples
        j <- 2 * i * (i + 1)
        while ( j <= sieve_bound ) {
            sieve[j] <- TRUE
            j <- j + 2 * i + 1
        }
    }
    i <- i + 1
}

sum <- 2 # 2 is a prime
i <- 1
while ( i <= sieve_bound ) {
    if ( !sieve[i] ) {
        sum <- sum + 2 * i + 1
    }
    i <- i + 1
}

cat(sum, fill=TRUE)
