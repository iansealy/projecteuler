# Power digit sum

Args  <- commandArgs()
power <- ifelse(is.na(Args[6]), 1000, as.numeric(Args[6]))

digits <- c(1)

for (i in seq(power)) {
    doubled_digits <- vector()
    carry <- 0
    for ( digit in digits ) {
        sum <- digit * 2 + carry

        # Get last digit of sum and keep carry over
        last_digit <- as.integer(substr(sum, nchar(sum), nchar(sum)))
        doubled_digits <- c(doubled_digits, last_digit)
        if ( sum >= 10 ) {
            carry <- as.integer(substr(sum, 1, nchar(sum)-1))
        } else {
            carry <- 0
        }
    }
    if ( carry > 0 ) {
        carry_digits <- as.integer(strsplit(as.character(carry), split=NULL)[[1]])
        doubled_digits <- c(doubled_digits, carry_digits)
    }
    digits = doubled_digits
}

cat(sum(digits), fill=TRUE)
