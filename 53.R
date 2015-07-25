# Combinatoric selections

# Constants
N <- 100

get_factorial_digits <- function(limit) {
    factorials <- c(1)

    digits <- c(1)
    for ( num in seq.int(limit) ) {
        new_digits <- vector()
        carry <- 0
        for ( digit in digits ) {
            prod <- digit * num + carry
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
        factorials <- c(factorials, length(new_digits))
        digits <- new_digits
    }

    return(factorials)
}

fac_digits <- get_factorial_digits(N)

greater_count <- 0
for ( n in seq.int(N) ) {
    for ( r in seq.int(n) ) {
        comb_digits <- fac_digits[n + 1] - fac_digits[r + 1] -
            fac_digits[n - r + 1]
        if ( comb_digits >= 7 ) {
            greater_count <- greater_count + 1
        } else if ( comb_digits >= 5 ) {
            comb <- prod(seq.int(r + 1, n))
            for ( i in seq.int(2, n - r) ) {
                comb <- comb / i
            }
            if ( comb > 1000000 ) {
                greater_count <- greater_count + 1
            }
        }
    }
}

cat(greater_count, fill=TRUE)
