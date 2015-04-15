# Special Pythagorean triplet

# Constants
SUM <- 1000

get_pythagorean_triplet_by_sum <- function(s) {
    s2     <- s %/% 2
    mlimit <- ceiling(sqrt(s2)) - 1
    for ( m in seq(2, mlimit) ) {
        if ( s2 %% m == 0 ) {
            sm <- s2 %/% m
            while ( sm %% 2 == 0 ) {
                sm <- sm %/% 2
            }
            k <- m + 1
            if ( m %% 2 == 1 ) {
                k <- m + 2
            }
            while ( k < 2 * m && k <= sm ) {
                if ( sm %% k == 0 && gcd(k, m) == 1 ) {
                    d <- s2 %/% ( k * m )
                    n <- k - m
                    a <- d * ( m * m - n * n )
                    b <- 2 * d * m * n
                    c <- d * ( m * m + n * n )
                    return( c(a, b, c) )
                }
                k <- k + 2
            }
        }
    }

    return( c(0, 0, 0) )
}

# Get greatest common divisor
gcd <- function(a, b) {
    if ( a > b ) {
        a.tmp <- a
        a <- b
        b <- a.tmp
    }

    while ( a ) {
        a.tmp <- a
        a <- b %% a
        b <- a.tmp
    }

    return(b)
}

triplet = get_pythagorean_triplet_by_sum( SUM )

cat(triplet[1] * triplet[2] * triplet[3], fill=TRUE)
