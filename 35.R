# Circular primes

Args <- commandArgs()
max  <- ifelse(is.na(Args[6]), 1000000, as.numeric(Args[6]))

get_primes_up_to <- function(limit) {
    sieve_bound <- (limit - 1) %/% 2 # Last index of sieve
    sieve <- rep(FALSE, sieve_bound)
    cross_limit <- (floor(sqrt(limit)) - 1) %/% 2

    i <- 1
    while ( i <= cross_limit ) {
        if (!sieve[i]) {
            # 2 * $i + 1 is prime, so mark multiples
            j <- 2 * i * (i + 1)
            while ( j <= sieve_bound ) {
                sieve[j] <- TRUE
                j <- j + 2 * i + 1
            }
        }
        i <- i + 1
    }

    primes <- rep(0, sieve_bound)
    for ( i in seq(1, sieve_bound) ) {
        if ( !sieve[i] ) {
            primes[i] <- 2 * i + 1
        }
    }

    return(c(2, primes[primes > 0]))
}

primes <- get_primes_up_to(max - 1)

circular <- vector()
for ( prime in primes ) {
    rotations <- vector()
    digits <- nchar(prime)
    for ( i in seq(digits) ) {
        prime <- prime %% 10 * 10 ^ (digits - 1) + prime %/% 10
        rotations <- c(rotations, prime)
    }
    if ( all(rotations %in% primes) ) {
        circular <- c(circular, prime)
    }
}

cat(length(circular), fill=TRUE)
