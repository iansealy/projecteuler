# Prime digit replacements

Args        <- commandArgs()
prime_value <- ifelse(is.na(Args[6]), 8, as.numeric(Args[6]))

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

get_smallest_prime <- function(digits, prime_value) {
    limit <- 10 ^ digits - 1
    primes <- get_primes_up_to(limit)
    primes <- primes[primes > 10 ^ (digits - 1)]
    is_prime <- new.env(hash=TRUE)
    for ( prime in primes ) {
        assign(as.character(prime), TRUE, is_prime)
    }
    for ( n in seq.int(digits - 1) ) {
        combinations <- combn(seq.int(digits), n, simplify=FALSE)
        for ( combination in combinations ) {
            prime_count <- new.env(hash=TRUE)
            for ( prime in primes ) {
                prime_base <- as.character(prime)
                removed <- vector()
                for ( pos in combination ) {
                    removed[substr(prime_base, pos, pos)] <- TRUE
                    substr(prime_base, pos, pos) <- '*'
                }
                if ( length(removed) == 1 ) {
                    if ( !exists(prime_base, prime_count) ) {
                        assign(prime_base, 0, prime_count)
                    }
                    assign(prime_base, get(prime_base, prime_count) + 1,
                           prime_count)
                }
            }
            for ( prime_base in ls(prime_count) ) {
                if ( get(prime_base, prime_count) != prime_value ) {
                    next
                }
                for ( replace in seq.int(0, 9) ) {
                    prime <- gsub('*', replace, prime_base, fixed=TRUE)
                    if ( exists(prime, is_prime) ) {
                        return(prime)
                    }
                }
            }
        }
    }
    return(NA)
}

digits <- 1
smallest_prime <- NA
while ( is.na(smallest_prime) ) {
    digits <- digits + 1
    smallest_prime <- get_smallest_prime(digits, prime_value)
}

cat(smallest_prime, fill=TRUE)
