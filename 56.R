# Powerful digit sum

# Constants
LIMIT <- 100

max_digit_sum <- 0

for ( a in seq.int(2, LIMIT) ) {
    digits <- rev(as.integer(strsplit(as.character(a), split=NULL)[[1]]))
    for ( b in seq.int(2, LIMIT) ) {
        new_digits <- vector()
        carry <- 0
        for ( i in seq.int(length(digits)) ) {
            prod <- digits[i] * a + carry
            last_digit <- as.integer(substr(prod, nchar(prod), nchar(prod)))
            new_digits <- c(new_digits, last_digit)
            if ( prod >= 10 ) {
                carry <- as.integer(substr(prod, 1, nchar(prod)-1))
            } else {
                carry <- 0
            }
        }
        if ( carry > 0 ) {
            carry_digits <- rev(as.integer(strsplit(as.character(carry),
                                                    split=NULL)[[1]]))
            new_digits <- c(new_digits, carry_digits)
        }
        digits <- new_digits
        if ( sum(digits) > max_digit_sum ) {
            max_digit_sum <- sum(digits)
        }
    }
}

cat(max_digit_sum, fill=TRUE)
