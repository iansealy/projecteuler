# Consecutive prime sum

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

primes <- get_primes_up_to(limit)
is_prime <- new.env(hash=TRUE)
for ( prime in primes ) {
    assign(as.character(prime), TRUE, is_prime)
}

max_consecutive <- 0
max_prime <- NA
for ( i in seq.int(length(primes)) ) {
    total <- 0
    for ( j in seq.int(i, length(primes)) ) {
        total <- total + primes[j]
        if ( total > limit ) {
            break
        }
        if ( exists(as.character(total), is_prime) &&
            j - i > max_consecutive ) {
            max_consecutive <- j - i
            max_prime <- total
        }
    }
}

cat(max_prime, fill=TRUE)
