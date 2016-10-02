# Hexagonal tile differences

Args    <- commandArgs()
ordinal <- ifelse(is.na(Args[6]), 2000, as.numeric(Args[6]))

top <- function(ring) {
    return(3 * ring * ring - 3 * ring + 2)
}

pd <- function(centre, neighbours) {
    return(sum(sapply(abs(centre - neighbours), is_prime)))
}

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

tile <- NA
ring <- 1
count <- 2 # PD(1) = 3 & PD(2) = 3
while ( TRUE ) {
    ring <- ring + 1

    # Top tile
    tile <- top(ring)
    neighbours <- c(
        top(ring + 1),
        top(ring + 1) + 1,
        top(ring) + 1,
        top(ring - 1),
        top(ring + 1) - 1,
        top(ring + 2) - 1
    )
    count <- count + sum(pd(tile, neighbours) == 3)
    if ( count == ordinal ) {
        break
    }

    # Last tile
    tile <- top(ring + 1) - 1
    neighbours <- c(
        top(ring + 2) - 1,
        top(ring),
        top(ring - 1),
        top(ring) - 1,
        top(ring + 1) - 2,
        top(ring + 2) - 2
    )
    count <- count + sum(pd(tile, neighbours) == 3)
    if ( count == ordinal ) {
        break
    }
}

cat(tile, fill=TRUE)
