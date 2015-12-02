# 10001st prime

Args    <- commandArgs()
ordinal <- ifelse(is.na(Args[6]), 10001, as.numeric(Args[6]))

is_prime <- function(num) {
    if ( num == 1 ) { # 1 isn't prime
        return(FALSE)
    }
    if ( num < 4 ) { # 2 and 3 are prime
        return(TRUE)
    }
    if ( num %% 2 == 0 ) { # Even numbers aren't prime
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

candidate <- 1
primes_got <- 1 # 2 is a prime

while ( primes_got < ordinal ) {
    candidate <- candidate + 2
    if ( is_prime(candidate) ) {
        primes_got <- primes_got + 1
    }
}

cat(candidate, fill=TRUE)
