# Counting fractions in a range

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 12000, as.numeric(Args[6]))

# Constants
LEFT_FRAC <- c(1, 3)
RIGHT_FRAC <- c(1, 2)

compare_fractions <- function(frac1, frac2) {
    big_numer1 = as.numeric(frac1[1]) * as.numeric(frac2[2])
    big_numer2 = as.numeric(frac2[1]) * as.numeric(frac1[2])

    if ( big_numer1 > big_numer2 ) {
        return(1)
    } else if ( big_numer1 < big_numer2 ) {
        return(-1)
    } else {
        return(0)
    }
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

count <- 0
for ( d in seq(2, limit) ) {
    start_n <- floor(LEFT_FRAC[1] / LEFT_FRAC[2] * d)
    end_n <- floor(RIGHT_FRAC[1] / RIGHT_FRAC[2] * d) + 1
    for ( n in seq(start_n, end_n) ) {
        if ( compare_fractions(c(n, d), LEFT_FRAC) <= 0 ) {
            next
        }
        if ( compare_fractions(c(n, d), RIGHT_FRAC) >= 0 ) {
            break
        }
        if ( gcd(n, d) == 1 ) {
            count <- count + 1
        }
    }
}

cat(count, fill=TRUE)
