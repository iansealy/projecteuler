# Special isosceles triangles

suppressPackageStartupMessages(library(Rmpfr))

options(scipen=100)

Args    <- commandArgs()
ordinal <- ifelse(is.na(Args[6]), 12, as.numeric(Args[6]))

fib <- function(n) {
    sqrt5 <- sqrt(mpfr(5, 64))
    n <- mpfr(n, 64)
    return(((1 + sqrt5) ^ n - (1 - sqrt5) ^ n) / (2 ^ n * sqrt5))
}

legs <- vector()
for ( n in seq.int(ordinal) ) {
    legs <- c(legs, as.numeric(fib(6 * n + 3) / 2))
}

cat(sum(legs), fill=TRUE)
