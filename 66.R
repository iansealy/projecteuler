# Diophantine equation

suppressPackageStartupMessages(library(gmp))

options(scipen=100)

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 1000, as.numeric(Args[6]))

n_with_largest_x <- NA
largest_x <- 0
for ( n in seq.int(2, limit) ) {
    if ( sqrt(n) == floor(sqrt(n)) ) {
        next
    }

    m <- as.bigz(0)
    d <- as.bigz(1)
    a <- as.bigz(floor(sqrt(n)))

    x_prev2 <- 1
    x_prev1 <- a[1]
    y_prev2 <- 0
    y_prev1 <- 1

    while ( TRUE ) {
        m <- c(m, d[length(d)] * a[length(a)] - m[length(m)])
        d <- c(d, (n - m[length(m)] * m[length(m)]) / d[length(d)])
        a <- c(a, (a[1] + m[length(m)]) %/% d[length(d)])

        x <- a[length(a)] * x_prev1 + x_prev2
        y <- a[length(a)] * y_prev1 + y_prev2

        if ( x * x - n * y * y == 1 ) {
            if ( x > largest_x ) {
                n_with_largest_x <- n
                largest_x <- x
            }
            break
        }

        x_prev2 <- x_prev1
        x_prev1 <- x
        y_prev2 <- y_prev1
        y_prev1 <- y
    }
}

cat(n_with_largest_x, fill=TRUE)
