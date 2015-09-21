# Counting fractions

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 1000000, as.numeric(Args[6]))

sieve <- seq.int(limit)
for ( i in seq.int(2, limit) ) {
    if ( sieve[i] == i ) {
        multiple <- i
        while ( multiple <= limit ) {
            sieve[multiple] <- sieve[multiple] * (1 - 1 / i)
            multiple <- multiple + i
        }
    }
}

cat(sum(sieve) - 1, fill=TRUE)
