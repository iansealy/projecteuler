# Bouncy numbers

library(memoise)

options(scipen=100)

Args     <- commandArgs()
exponent <- ifelse(is.na(Args[6]), 100, as.numeric(Args[6]))

count_increasing <- memoise(function(last_digit, len) {
    if ( len == 1 ) {
        return(1)
    }

    count <- 0
    for ( prev_last_digit in seq.int(last_digit) ) {
        count <- count + count_increasing(prev_last_digit, len - 1)
    }

    return(count)
})

count_decreasing <- memoise(function(last_digit, len) {
    if ( len == 1 ) {
        return(1)
    }

    count <- 0
    for ( prev_last_digit in seq.int(last_digit, 9) ) {
        count <- count + count_decreasing(prev_last_digit, len - 1)
    }

    return(count)
})

increasing <- 0
for ( num_digits in seq.int(exponent) ) {
    for ( last_digit in seq.int(9) ) {
        increasing <- increasing + count_increasing(last_digit, num_digits)
    }
}

decreasing <- 0
for ( num_digits in seq.int(exponent) ) {
    for ( last_digit in seq.int(0, 9) ) {
        decreasing <- decreasing + count_decreasing(last_digit, num_digits)
    }
    decreasing <- decreasing - 1
}

double_count <- 9 * exponent

cat(increasing + decreasing - double_count, fill=TRUE)
