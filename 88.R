# Product-sum numbers

Args <- commandArgs()
max  <- ifelse(is.na(Args[6]), 12000, as.numeric(Args[6]))

factors_for <- vector("list", 2 * max)
min_prod_sum <- rep(NA, max)

for ( n in seq.int(4, 2 * max) ) {
    for ( low_factor in seq.int(2, floor(sqrt(n))) ) {
        if ( n %% low_factor != 0 ) {
            next
        }
        high_factor <- n / low_factor
        factors_for[[n]] <- c(factors_for[[n]],
                              list(c(low_factor, high_factor)))
        for ( factors in factors_for[[high_factor]] ) {
            if ( low_factor > factors[1] ) {
                next
            }
            factors_for[[n]] <- c(factors_for[[n]],
                                  list(c(low_factor, factors)))
        }
    }
}

for ( n in seq.int(2, 2 * max) ) {
    for ( factors in factors_for[[n]] ) {
        factor_sum <- sum(factors)
        if ( factor_sum > n ) {
            next
        }
        k <- n - factor_sum + length(factors)
        if ( k > max ) {
            next
        }
        if ( is.na(min_prod_sum[k]) || min_prod_sum[k] > n ) {
            min_prod_sum[k] <- n
        }
    }
}

cat(sum(unique(min_prod_sum), na.rm=TRUE), fill=TRUE)
