# Large repunit factors

Args  <- commandArgs()
k       <- ifelse(is.na(Args[6]), 10 ^ 9, as.numeric(Args[6]))
factors <- ifelse(is.na(Args[7]), 40,     as.numeric(Args[7]))

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

modular_exponentiation <- function(base, exp, mod) {
    result <- 1
    base <- base %% mod
    while ( exp > 0 ) {
        if ( exp %% 2 == 1 ) {
            result <- (result * base) %% mod
        }
        exp <- bitwShiftR(exp, 1)
        base <- (base * base) %% mod
    }

    return(result)
}

limit <- 1000
prime_factors <- vector()
while ( length(prime_factors) < factors ) {
    prime_factors <- vector()
    limit <- limit * 10
    primes <- get_primes_up_to(limit)
    for ( prime in primes ) {
        if ( modular_exponentiation(10, k, 9 * prime) == 1 ) {
            prime_factors <- c(prime_factors, prime)
            if ( length(prime_factors) == factors ) {
                break
            }
        }
    }
}

cat(sum(prime_factors), fill=TRUE)
