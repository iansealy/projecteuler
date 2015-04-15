# Largest palindrome product

Args   <- commandArgs()
digits <- ifelse(is.na(Args[6]), 3, as.numeric(Args[6]))

high_num <- 10 ^ digits - 1
low_num  <- 10 ^ (digits - 1)

is_palindrome <- function(number) {
    digit_chars <- strsplit(as.character(as.integer(number)), split=NULL)[[1]]
    reversed_number <- as.integer(paste(rev(digit_chars), collapse=''))
    return(number == reversed_number)
}

max <- 0

num1 <- high_num
while ( num1 >= low_num ) {
    num2 <- num1
    decrease <- 1
    if ( num2 %% 11 ) {
        num2 <- num2 %/% 11 * 11
        decrease <- 11
    }
    while ( num2 >= low_num ) {
        product <- num1 * num2
        if ( product > max & is_palindrome(product) ) {
            max <- product
        }
        num2 <- num2 - decrease
    }
    num1 <- num1 - 1
}

cat(max, fill=TRUE)
