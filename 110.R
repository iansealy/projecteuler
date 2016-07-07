# Diophantine reciprocals II

options(scipen=100)

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 4e6, as.numeric(Args[6]))

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

primes <- get_primes_up_to(sqrt(limit))

max_primes <- ceiling(log(2 * limit, 3))
primes <- primes[1:max_primes]

exponent_set <- c(1)
min_n2 <- NA
prev_min_n2 <- NA
while ( is.na(prev_min_n2) || min_n2 != prev_min_n2 ) {
    prev_min_n2 <- min_n2
    exponent_set <- c(exponent_set, exponent_set[length(exponent_set)] + 2)
    idx <- rep(1, max_primes)
    while ( TRUE ) {
        finished <- TRUE
        for ( i in rev(seq.int(max_primes)) ) {
            if ( idx[i] != length(exponent_set) ) {
                finished <- FALSE
                break
            }
        }
        if ( finished ) {
            break
        }
        idx[i:length(idx)] <- rep(idx[i] + 1, max_primes - i + 1)
        product <- prod(exponent_set[idx])
        if ( product > 2 * limit ) {
            exponents <- rev(exponent_set[idx])
            n2 <- 1
            for ( j in seq.int(max_primes) ) {
                n2 <- n2 * primes[j] ^ (exponents[j] - 1)
            }
            if ( !is.na(min_n2) && n2 >= min_n2 ) {
                next
            }
            min_n2 <- n2
        }
    }
}

cat(sqrt(min_n2), fill=TRUE)
