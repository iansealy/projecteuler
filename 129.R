# Repunit divisibility

Args   <- commandArgs()
minimum <- ifelse(is.na(Args[6]), 1000000, as.numeric(Args[6]))

n <- minimum
while ( TRUE ) {
    n <- n + 1
    if ( n %% 2 == 0 || n %% 5 == 0 ) {
        next
    }
    rkmodn <- 1
    k <- 1
    while ( rkmodn %% n != 0 ) {
        k <- k + 1
        rkmodn <- (rkmodn * 10 + 1) %% n
    }
    if ( k > minimum ) {
        break
    }
}

cat(n, fill=TRUE)
