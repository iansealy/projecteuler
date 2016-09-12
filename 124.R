# Ordered radicals

Args    <- commandArgs()
limit   <- ifelse(is.na(Args[6]), 100000, as.numeric(Args[6]))
ordinal <- ifelse(is.na(Args[7]), 10000,  as.numeric(Args[7]))

radicals <- rep(1, limit)
for ( n in seq.int(2, limit) ) {
    if ( radicals[n] == 1 ) {
        radicals[n] <- n
        multiple <- n + n
        while ( multiple <= limit ) {
            radicals[multiple] <- radicals[multiple] * n
            multiple <- multiple + n
        }
    }
}

cat(order(radicals)[ordinal], fill=TRUE)
