# Counting fractions

options(scipen=100)

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 1000000, as.numeric(Args[6]))

sieve_limit <- (floor(sqrt(limit)) - 1) %/% 2
if ( sieve_limit == 0 ) {
    sieve_limit <- 1
}
max_index <- (limit - 1) %/% 2
cache <- rep(0, max_index)
for ( n in seq.int(sieve_limit) ) {
    if ( cache[n] == 0 ) {
        k <- 2 * n * (n + 1)
        p <- 2 * n + 1
        while ( k <= max_index ) {
            if ( cache[k] == 0 ) {
                cache[k] <- p
            }
            k <- k + p
        }
    }
}
multiplier <- 1
while ( multiplier <= limit ) {
    multiplier <- multiplier * 2
}
multiplier <- multiplier %/% 2
count <- multiplier - 1
multiplier <- multiplier %/% 2
step_index <- ((limit %/% multiplier) + 1) %/% 2
for ( n in seq.int(max_index) ) {
    if ( n == step_index ) {
        multiplier <- multiplier %/% 2
        step_index <- ((limit %/% multiplier) + 1) %/% 2
    }
    if ( cache[n] == 0 ) {
        cache[n] <- 2 * n
        count <- count + multiplier * cache[n]
    } else {
        p <- cache[n]
        cofactor <- (2 * n + 1) %/% p
        factor <- p
        if ( cofactor %% p ) {
            factor <- p - 1
        }
        cache[n] <- factor * cache[cofactor %/% 2]
        count <- count + multiplier * cache[n]
    }
}

cat(count, fill=TRUE)
