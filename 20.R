# Factorial digit sum

Args      <- commandArgs()
factorial <- ifelse(is.na(Args[6]), 100, as.numeric(Args[6]))

digits <- c(1)

for (number in seq(2, factorial)) {
    multiplied_digits <- vector()
    carry <- 0
    for ( digit in digits ) {
        sum <- digit * number + carry

        # Get last digit of sum and keep carry over
        last_digit <- as.integer(substr(sum, nchar(sum), nchar(sum)))
        multiplied_digits <- c(multiplied_digits, last_digit)
        if ( sum >= 10 ) {
            carry <- as.integer(substr(sum, 1, nchar(sum)-1))
        } else {
            carry <- 0
        }
    }
    if ( carry > 0 ) {
        carry_digits <- rev(as.integer(strsplit(as.character(carry),
                                                split=NULL)[[1]]))
        multiplied_digits <- c(multiplied_digits, carry_digits)
    }
    digits = multiplied_digits
}

cat(sum(digits), fill=TRUE)
