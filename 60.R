# Prime pair sets

Args     <- commandArgs()
set_size <- ifelse(is.na(Args[6]), 5, as.numeric(Args[6]))

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

is_prime <- function(num) {
    if ( num == 1 ) { # 1 isn't prime
        return(FALSE)
    }
    if ( num < 4 ) { # 2 and 3 are prime
        return(TRUE)
    }
    if ( num %% 2 == 0 ) { # Odd numbers aren't prime
        return(FALSE)
    }
    if ( num < 9 ) { # 5 and 7 are prime
        return(TRUE)
    }
    if ( num %% 3 == 0 ) { # Numbers divisible by 3 aren't prime
        return(FALSE)
    }

    num_sqrt <- as.integer(sqrt(num))
    factor <- 5
    while ( factor <= num_sqrt ) {
        if ( num %% factor == 0 ) { # Primes greater than three are 6k-1
            return(FALSE)
        }
        if ( num %% (factor + 2) == 0 ) { # Or 6k+1
            return(FALSE)
        }
        factor <- factor + 6
    }
    return(TRUE)
}

get_set <- function(pair, candidates, set, set_size, min_set_sum) {
    set_sum <- sum(set)

    if ( length(set) == set_size ) {
        if ( set_sum < min_set_sum ) {
            return(set_sum)
        } else {
            return(min_set_sum)
        }
    }

    for ( prime in candidates ) {
        if ( set_sum + prime > min_set_sum ) {
            return(min_set_sum)
        }
        new_candidates <- intersect(candidates, pair$p2[pair$p1 == prime])
        min_set_sum <- get_set(pair, new_candidates, c(set, prime), set_size, min_set_sum)
    }

    return(min_set_sum)
}

limit <- 10
min_set_sum <- limit * limit

while ( min_set_sum == limit * limit ) {
    limit <- limit * 10
    min_set_sum <- limit * limit

    primes <- get_primes_up_to(limit)

    pair <- expand.grid(primes, primes)
    colnames(pair) <- c('p1', 'p2')
    pair <- pair[pair$p1 < pair$p2,]
    pair$c1 <- as.integer(paste(as.character(pair$p1), as.character(pair$p2), sep=""))
    pair$c2 <- as.integer(paste(as.character(pair$p2), as.character(pair$p1), sep=""))
    pair <- pair[sapply(pair$c1, is_prime) & sapply(pair$c2, is_prime),]
    pair <- pair[order(pair$p1, pair$p2),]

    for ( prime in unique(pair$p1) ) {
        if ( prime > min_set_sum ) {
            break
        }
        min_set_sum <- get_set(pair, pair$p2[pair$p1 == prime], prime, set_size, min_set_sum)
    }
}

cat(min_set_sum, fill=TRUE)
