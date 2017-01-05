# Modified Fibonacci golden nuggets

suppressPackageStartupMessages(library(Rmpfr))

options(scipen=100)

Args    <- commandArgs()
ordinal <- ifelse(is.na(Args[6]), 30, as.numeric(Args[6]))

nuggets <- vector()
n <- 0
up_or_down <- 1
while ( length(nuggets) < ordinal ) {
    n <- n + up_or_down
    discriminant <- sqrt(5 * n * n + 14 * n + 1)
    if ( floor(discriminant) == discriminant ) {
        nuggets <- c(nuggets, n)
        num_nuggets <- length(nuggets)
        if ( num_nuggets > 2 ) {
            up_or_down <- -1
            n <- floor(nuggets[num_nuggets - 1] *
                       nuggets[num_nuggets] / nuggets[num_nuggets - 2])
        }
    }
}

cat(sum(nuggets), fill=TRUE)
