# 10001st prime

Args    <- commandArgs()
ordinal <- ifelse(is.na(Args[6]), 10001, as.numeric(Args[6]))

primes <- c(2, 3)
num <- 5

while ( length(primes) < ordinal ) {
    is_prime <- TRUE
    num_sqrt <- as.integer(sqrt(num))
    for ( prime in primes ) {
        if ( prime > num_sqrt ) {
            break
        }
        if ( num %% prime == 0 ) {
            is_prime <- FALSE
            break
        }
    }
    if ( is_prime ) {
        primes <- c(primes, num)
    }
    num <- num + 2
}

cat(max(primes), fill=TRUE)
