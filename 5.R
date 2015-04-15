# Smallest multiple

Args    <- commandArgs()
max_num <- ifelse(is.na(Args[6]), 20, as.numeric(Args[6]))

get_factors <- function(number) {
    factors <- numeric()

    div <- 2

    while ( div <= as.integer(sqrt(number)) ) {
        while ( number %% div == 0 ) {
            number = number / div
            factors <- c(factors, div)
        }

        # Don't bother testing even numbers (except two)
        if ( div > 2 ) {
            div <- div + 2
        }
        else {
            div <- div + 1
        }
    }

    if ( number > 1 ) {
        factors <- c(factors, number)
    }

    return(factors)
}

all_factors <- numeric()

for ( num in 2:max_num ) {
    factors <- get_factors(num)
    factor_count <- table(factors)
    for ( factor in names(factor_count) ) {
        if ( !factor %in% names(table(all_factors))
            || factor_count[[factor]] > table(all_factors)[[factor]] ) {
            all_factors <- c(all_factors, factor)
        }
    }
}

cat(prod(as.numeric(all_factors)), fill=TRUE)
