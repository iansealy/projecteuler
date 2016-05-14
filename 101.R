# Optimum polynomial

# Constants
MAX_N <- 11

polynomial <- function(n) {
    return(1 - n + n^2 - n^3 + n^4 - n^5 + n^6 - n^7 + n^8 - n^9 + n^10)
}

poly_seq <- sapply(seq.int(MAX_N), polynomial)

fits_sum <- 0

for ( k in seq.int(MAX_N - 1) ) {
    potential_fit <- 0
    for ( i in seq.int(k) ) {
        numer <- 1
        denom <- 1
        for ( j in seq.int(k) ) {
            if ( i == j ) {
                next
            }
            numer = numer * (k + 1 - j)
            denom = denom * (i - j)
        }
        potential_fit <- potential_fit + poly_seq[i] * numer / denom
    }
    if ( potential_fit != poly_seq[k + 1] ) {
        fits_sum <- fits_sum + potential_fit
    }
}

cat(fits_sum, fill=TRUE)
