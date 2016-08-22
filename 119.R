# Digit power sum

suppressPackageStartupMessages(library(gmp))

options(scipen=100)

Args    <- commandArgs()
ordinal <- ifelse(is.na(Args[6]), 30, as.numeric(Args[6]))

sum_sequence <- vector()
digit_sum <- as.bigz(1)
while ( length(sum_sequence) < 2 * ordinal ) {
    digit_sum <- digit_sum + 1
    pow <- digit_sum
    while ( nchar(as.character(pow)) < digit_sum ) {
        pow <- pow * digit_sum
        if ( pow < 10 ) {
            next
        }
        power_sum <- sum(as.integer(strsplit(as.character(pow), NULL)[[1]]))
        if ( power_sum == digit_sum ) {
            sum_sequence <- c(sum_sequence, as.character(pow))
        }
    }
}

cat(sort(sum_sequence)[ordinal], fill=TRUE)
