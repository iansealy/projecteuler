# Spiral primes

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

prime_diagonals <- 0
total_diagonals <- 0

width <- 1
increment <- 0
number <- 1

while ( total_diagonals == 0 || prime_diagonals / total_diagonals > 0.1 ) {
    width <- width + 2
    increment <- increment + 2
    total_diagonals <- total_diagonals + 4
    for ( i in seq(4) ) {
        number <- number + increment
        if ( is_prime(number) ) {
            prime_diagonals <- prime_diagonals + 1
        }
    }
}

cat(width, fill=TRUE)
