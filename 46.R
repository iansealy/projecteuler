# Goldbach's other conjecture

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

get_twice_squares_up_to <- function(limit) {
    twice_squares <- c(2)
    i <- 1
    while ( tail(twice_squares, 1) < limit ) {
        i <- i + 1
        twice_squares <- c(twice_squares, 2 * i * i)
    }

    return(twice_squares)
}

limit <- 100
smallest <- NA
while ( is.na(smallest) ) {
    limit <- limit * 10
    primes <- get_primes_up_to(limit)
    is_prime <- new.env(hash=TRUE)
    for ( prime in primes ) {
        assign(as.character(prime), TRUE, is_prime)
    }
    twice_squares <- get_twice_squares_up_to(limit)
    is_twice_square <- new.env(hash=TRUE)
    for ( twice_square in twice_squares ) {
        assign(as.character(twice_square), TRUE, is_twice_square)
    }
    n <- 1
    while ( n < limit ) {
        n <- n + 2
        if ( exists(as.character(n), is_prime) ) {
            next
        }
        is_prime_plus_twice_square <- FALSE
        for ( prime in primes ) {
            if ( prime >= n ) {
                break
            }
            if ( exists(as.character(n - prime), is_twice_square) ) {
                is_prime_plus_twice_square <- TRUE
                break
            }
        }
        if ( !is_prime_plus_twice_square ) {
            smallest <- n
            break
        }
    }
}

cat(smallest, fill=TRUE)
