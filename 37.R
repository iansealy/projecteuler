# Truncatable primes

# Constants
TARGET_TRUNCATABLE <- 11

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

is_truncatable <- function(prime, is_prime) {
    if ( prime < 10 ) {
        return(FALSE)
    }

    digits <- strsplit(as.character(prime), split=NULL)[[1]]

    for ( i in seq.int(2, length(digits)) ) {
        truncated1 <- paste(digits[i:length(digits)], collapse='')
        truncated2 <- paste(digits[1:(i-1)], collapse='')
        if ( !exists(truncated1, is_prime) || !exists(truncated2, is_prime) ) {
            return(FALSE)
        }
    }

    return(TRUE)
}

max_prime <- 1
truncatable <- vector()

while ( length(truncatable) < TARGET_TRUNCATABLE ) {
    max_prime <- max_prime * 10
    truncatable <- vector()

    primes <- get_primes_up_to(max_prime)
    is_prime <- new.env(hash=TRUE)
    for ( prime in primes ) {
        assign(as.character(prime), TRUE, is_prime)
        if ( is_truncatable(prime, is_prime) ) {
            truncatable <- c(truncatable, prime)
        }
    }
}

cat(sum(truncatable), fill=TRUE)
