# 1000-digit Fibonacci number

Args   <- commandArgs()
digits <- ifelse(is.na(Args[6]), 1000, as.numeric(Args[6]))

ordinal <- 1
fib1 <- c(1)
fib2 <- c(1)

while ( length(fib1) < digits ) {
    ordinal <- ordinal + 1
    carry <- 0
    sum <- vector()
    for ( digit in seq(length(fib2)) ) {
        fib1_digit <- ifelse(is.na(fib1[digit]), 0, fib1[digit])
        digit_sum <- fib2[digit] + fib1_digit + carry
        last_digit <- as.integer(substr(digit_sum, nchar(digit_sum),
                                        nchar(digit_sum)))
        sum <- c(sum, last_digit)
        if ( digit_sum >= 10 ) {
            carry <- as.integer(substr(digit_sum, 1, nchar(digit_sum)-1))
        } else {
            carry <- 0
        }
    }
    if ( carry > 0 ) {
        carry_digits <- rev(as.integer(strsplit(as.character(carry),
                                                split=NULL)[[1]]))
        sum <- c(sum, carry_digits)
    }
    fib1 <- fib2
    fib2 <- sum
}

cat(ordinal, fill=TRUE)
