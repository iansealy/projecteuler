# Repunit nonfactors

options(scipen=100)

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 100000, as.numeric(Args[6]))

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

mod_exp <- function(base, exp, mod) {
    result <- 1
    base <- base %% mod
    while ( exp > 0 ) {
        if ( exp %% 2 == 1 ) {
            result <- (result * base) %% mod
        }
        exp <- floor(exp / 2)
        base <- (base * base) %% mod
    }

    return(result)
}

primes <- get_primes_up_to(limit)
for ( n in seq.int(16) ) {
    delete <- vector()
    for ( prime in primes ) {
        if ( suppressWarnings(mod_exp(10, 10 ^ n, 9 * prime )) == 1 ) {
            delete <- c(delete, prime)
        }
    }
    primes <- setdiff(primes, delete)
}

cat(sum(primes), fill=TRUE)
