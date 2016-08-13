# Pandigital prime sets

library(gtools)

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

sets <- function(max_digits, len, primes) {
    if ( len ) {
        digits <- unique(unlist(strsplit(as.character(primes), split=NULL)))
        if ( length(digits) < len ) {
            return(0)
        }
        if ( len == 9 ) {
            return(1)
        }
    }

    count <- 0
    for ( num_digits in seq.int(max_digits, 1) ) {
        if ( len + num_digits > 9 ) {
            next
        }
        for ( prime in primes_for[[num_digits]] ) {
            if ( length(primes) && prime > primes[length(primes)] ) {
                break
            }
            count <- count + sets(num_digits, len + num_digits,
                                  c(primes, prime))
        }
    }
    return(count)
}

primes <- get_primes_up_to(as.integer(sqrt(100000000)))
primes_for <- list()
primes_for[[9]] <- vector()
for ( digits in seq.int(8) ) {
    perms <- permutations(9, digits)
    perms <- as.integer(apply(perms, 1, paste, collapse=""))
    for ( num in primes ) {
        perms <- perms[as.logical(perms %% num) | perms == num]
    }
    primes_for[[digits]] <- perms
}
primes_for[[1]] <- primes_for[[1]][primes_for[[1]] > 1]

cat(sets(9, 0, vector()), fill=TRUE)
