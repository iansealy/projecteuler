# Distinct powers

Args <- commandArgs()
max  <- ifelse(is.na(Args[6]), 100, as.numeric(Args[6]))

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

get_prime_factors <- function(number, primes) {
    factors <- vector()

    for ( prime in primes ) {
        while ( number %% prime == 0 ) {
            factors <- c(factors, prime)
            number <- number / prime
        }
    }

    return(factors)
}

primes <- get_primes_up_to(max)

terms <- vector()
for ( a in seq.int(2, max) ) {
    a_factors <- get_prime_factors(a, primes)
    for ( b in seq.int(2, max) ) {
        factors <- rep(a_factors, each=b)
        factors <- paste(factors, collapse='*')
        if ( !(factors %in% terms) ) {
            terms <- c(terms, factors)
        }
    }
}

cat(length(terms), fill=TRUE)
