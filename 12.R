# Highly divisible triangular number

Args     <- commandArgs()
divisors <- ifelse(is.na(Args[6]), 500, as.numeric(Args[6]))

get_factors <- function(number) {
    factors <- c(1, number)

    for ( i in seq.int(2, as.integer(sqrt(number))) ) {
        if ( number %% i == 0 ) {
            factors <- c(factors, i, number %/% i)
        }
    }

    return(factors)
}

ordinal <- 1
triangle_number <- 1
num_factors <- 1

while ( num_factors <= divisors ) {
    ordinal <- ordinal + 1
    triangle_number <- triangle_number + ordinal
    num_factors <- length(get_factors(triangle_number))
}

cat(triangle_number, fill=TRUE)
