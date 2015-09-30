# Counting fractions in a range

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 12000, as.numeric(Args[6]))

f <- function(n) {
    q <- n %/% 6
    r <- n %% 6
    f <- q * (3 * q - 2 + r)
    if ( r == 5 ) {
        f <- f + 1
    }
    return(f)
}

r <- function(n) {
    switch <- floor(sqrt(n / 2))
    count <- f(n)
    count <- count - f(n %/% 2)
    m <- 5
    k <- (n - 5) %/% 10
    while ( k >= switch ) {
        next_k <- (n %/% (m + 1) - 1) %/% 2
        count <- count - (k - next_k) * r_small[m + 1]
        k <- next_k
        m <- m + 1
    }
    while ( k > 0 ) {
        m <- n %/% (2 * k + 1)
        if ( m <= m0 ) {
            count <- count - r_small[m + 1]
        } else {
            count <- count - r_large[(((limit %/% m) - 1) %/% 2) + 1]
        }
        k <- k - 1
    }
    if ( n <= m0 ) {
        r_small[n + 1] <<- count
    } else {
        r_large[(((limit %/% n) - 1) %/% 2) + 1] <<- count
    }
}

k0 <- floor(sqrt(limit / 2))
m0 <- floor(limit / (2 * k0 + 1))
r_small <- vector()
r_large <- vector()

for ( n in seq.int(5, m0) ) {
    r(n)
}
for ( j in seq.int(k0 - 1, 0) ) {
    r(limit %/% (2 * j + 1))
}

cat(r_large[1], fill=TRUE)
