# Fibonacci golden nuggets

options(scipen=100)

Args    <- commandArgs()
ordinal <- ifelse(is.na(Args[6]), 15, as.numeric(Args[6]))

fib <- function(n) {
    return(((1 + sqrt(5)) ^ n - (1 - sqrt(5)) ^ n) / (2 ^ n * sqrt(5)))
}

cat(fib(2 * ordinal) * fib(2 * ordinal + 1), fill=TRUE)
