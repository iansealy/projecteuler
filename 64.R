# Odd period square roots

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 10000, as.numeric(Args[6]))

odd_count <- 0
for ( n in seq.int(2, limit) ) {
    if ( sqrt(n) == floor(sqrt(n)) ) {
        next
    }

    m <- 0
    d <- 1
    a <- floor(sqrt(n))

    while ( a[length(a)] != 2 * a[1] ) {
        m <- c(m, d[length(d)] * a[length(a)] - m[length(m)])
        d <- c(d, (n - m[length(m)] * m[length(m)]) / d[length(d)])
        a <- c(a, floor((a[1] + m[length(m)]) / d[length(d)]))
    }
    if ( length(a) %% 2 == 0 ) {
        odd_count <- odd_count + 1
    }
}

cat(odd_count, fill=TRUE)
