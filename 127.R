# abc-hits

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 120000, as.numeric(Args[6]))

# Get greatest common divisor
gcd <- function(a, b) {
    if ( a > b ) {
        a.tmp <- a
        a <- b
        b <- a.tmp
    }

    while ( a ) {
        a.tmp <- a
        a <- b %% a
        b <- a.tmp
    }

    return(b)
}

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

indices <- order(radicals)

abc_a <- vector()
abc_b <- vector()
for ( c in indices ) {
    rad_a_or_b_limit <- as.integer(sqrt(c / radicals[c]))
    for ( a_or_b in indices ) {
        if ( radicals[a_or_b] > rad_a_or_b_limit ) {
            break
        }
        if ( a_or_b >= c ) {
            next
        }
        a <- a_or_b
        b <- c - a_or_b
        if ( a > b ) {
            a <- c - a_or_b
            b <- a_or_b
        }
        if ( radicals[a] * radicals[b] * radicals[c] >= c ) {
            next
        }
        if ( gcd(a, b) > 1 ) {
            next
        }
        abc_a <- c(abc_a, a)
        abc_b <- c(abc_b, b)
    }
}

pairs <- unique(data.frame(a=abc_a, b=abc_b))

cat(sum(pairs$a + pairs$b), fill=TRUE)
