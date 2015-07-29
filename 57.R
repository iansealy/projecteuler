# Square root convergents

# Constants
LIMIT <- 1000

num_fractions <- 0

denom_prev1 <- c(5)
denom_prev2 <- c(2)
for ( x in seq.int(3, LIMIT) ) {
    denom <- vector()
    numer <- vector()
    carry_denom <- 0
    carry_numer <- 0
    for ( i in seq.int(length(denom_prev1)) ) {
        prev2_digit <- 0
        if ( i <= length(denom_prev2) ) {
            prev2_digit <- denom_prev2[i]
        }
        sum_denom <- 2 * denom_prev1[i] + prev2_digit + carry_denom
        sum_numer <- 3 * denom_prev1[i] + prev2_digit + carry_numer
        last_denom_digit <- as.integer(substr(sum_denom, nchar(sum_denom), nchar(sum_denom)))
        last_numer_digit <- as.integer(substr(sum_numer, nchar(sum_numer), nchar(sum_numer)))
        denom <- c(denom, last_denom_digit)
        numer <- c(numer, last_numer_digit)
        carry_denom <- 0
        carry_numer <- 0
        if ( sum_denom >= 10 ) {
            carry_denom <- as.integer(substr(sum_denom, 1, nchar(sum_denom)-1))
        }
        if ( sum_numer >= 10 ) {
            carry_numer <- as.integer(substr(sum_numer, 1, nchar(sum_numer)-1))
        }
    }
    if ( carry_denom > 0 ) {
        carry_digits <- rev(as.integer(strsplit(as.character(carry_denom), split=NULL)[[1]]))
        denom <- c(denom, carry_digits)
    }
    if ( carry_numer > 0 ) {
        carry_digits <- rev(as.integer(strsplit(as.character(carry_numer), split=NULL)[[1]]))
        numer <- c(numer, carry_digits)
    }
    if ( length(numer) > length(denom) ) {
        num_fractions <- num_fractions + 1
    }
    denom_prev2 <- denom_prev1
    denom_prev1 <- denom
}
cat(num_fractions, fill=TRUE)
