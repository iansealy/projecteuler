# Prime pair connection

suppressPackageStartupMessages(library(gmp))

options(scipen=100)

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 1000000, as.numeric(Args[6]))

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

primes <- get_primes_up_to(limit * 1.1)
primes <- primes[primes >= 5]
num_below_limit <- sum(primes <= limit)
primes <- primes[1:(num_below_limit + 1)]

total <- as.bigz(0)

for ( i in seq.int(length(primes) - 1) ) {
    prime1 <- primes[i]
    prime2 <- primes[i + 1]
    n <- prime2
    multiplier <- 2
    digits <- nchar(as.character(prime1))
    while ( n %% 10 ^ digits != prime1 ) {
        potential_multiplier <- 10
        while ( n %% potential_multiplier == prime1 %% potential_multiplier ) {
            multiplier <- potential_multiplier
            potential_multiplier <- potential_multiplier * 10
        }
        n <- n + prime2 * multiplier
    }
    total <- total + n
}

cat(as.character(total), fill=TRUE)
