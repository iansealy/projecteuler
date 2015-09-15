# Ordered fractions

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 1000000, as.numeric(Args[6]))

# Constants
RIGHT_FRAC <- c(3, 7)

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

left_frac <- c(2, 7)
for ( d in seq(2, limit) ) {
    start_n <- floor(left_frac[1] / left_frac[2] * d)
    end_n <- floor(RIGHT_FRAC[1] / RIGHT_FRAC[2] * d) + 1
    for ( n in seq(start_n, end_n) ) {
        if ( compare_fractions(c(n, d), RIGHT_FRAC) >= 0 ) {
            next
        }
        if ( compare_fractions(c(n, d), left_frac) > 0 ) {
            left_frac <- c(n, d)
        }
    }
}

cat(left_frac[1], fill=TRUE)
