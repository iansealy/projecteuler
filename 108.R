# Diophantine reciprocals I

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 1000, as.numeric(Args[6]))

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

get_num_divisors <- function(number, primes) {
    num_divisors <- 1

    for ( prime in primes ) {
        if ( prime * prime > limit ) {
            break
        }
        exponent <- 1
        while ( number %% prime == 0 ) {
            exponent <- exponent + 1
            number <- number / prime
        }
        num_divisors <- num_divisors * exponent
    }

    return(num_divisors)
}

primes <- get_primes_up_to(limit)

n <- 0
solutions <- 0
while ( solutions <= limit ) {
    n <- n + 1
    num_divisors <- get_num_divisors(n * n, primes)
    solutions <- (num_divisors + 1) %/% 2
}

cat(n, fill=TRUE)
