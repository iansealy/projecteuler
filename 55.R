# Lychrel numbers

# Constants
LIMIT <- 10000

add_reverse <- function(digits) {
    reverse_digits <-rev(digits)
    new_digits <- vector()
    carry <- 0
    for ( i in seq.int(length(digits)) ) {
        sum <- digits[i] + reverse_digits[i] + carry
        last_digit <- as.integer(substr(sum, nchar(sum), nchar(sum)))
        new_digits <- c(new_digits, last_digit)
        if ( sum >= 10 ) {
            carry <- as.integer(substr(sum, 1, nchar(sum)-1))
        } else {
            carry <- 0
        }
    }
    if ( carry > 0 ) {
        carry_digits <- rev(as.integer(strsplit(as.character(carry),
                                                split=NULL)[[1]]))
        new_digits <- c(new_digits, carry_digits)
    }

    return(new_digits)
}

is_palindrome <- function(digits) {
    return(identical(digits, rev(digits)))
}

count <- 0

for ( num in seq.int(LIMIT) ) {
    digits <- as.integer(strsplit(as.character(num), split=NULL)[[1]])
    is_lychrel <- TRUE
    for ( i in seq.int(50) ) {
        digits <- add_reverse(digits)
        if ( is_palindrome(digits) ) {
            is_lychrel <- FALSE
            break
        }
    }
    if ( is_lychrel ) {
        count <- count + 1
    }
}

cat(count, fill=TRUE)
