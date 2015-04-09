# Non-abundant sums

# Constants
HIGHEST_ABUNDANT_SUM <- 28123

sum_proper_divisors <- function(number) {
    return(sum_divisors(number) - number)
}

sum_divisors <- function(number) {
    divisor_sum <- 1
    prime <- 2

    while ( prime * prime <= number && number > 1 ) {
        if ( number %% prime == 0 ) {
            j <- prime * prime
            number <- number %/% prime
            while ( number %% prime == 0 ) {
                j <- j * prime
                number <- number %/% prime
            }
            divisor_sum <- divisor_sum * ( j - 1 )
            divisor_sum <- divisor_sum %/% ( prime - 1 )
        }
        if ( prime == 2 ) {
            prime <- 3
        } else {
            prime <- prime + 2
        }
    }
    if ( number > 1 ) {
        divisor_sum <- divisor_sum * ( number + 1 )
    }

    return(divisor_sum)
}

abundant_numbers <- sapply(seq.int(HIGHEST_ABUNDANT_SUM), function(i) {
    return(sum_proper_divisors(i) > i)
})
abundant_numbers <- seq.int(HIGHEST_ABUNDANT_SUM)[abundant_numbers]

abundant_sum <- unique(as.vector(outer(abundant_numbers, abundant_numbers,
                                       '+')))
abundant_sum <- abundant_sum[abundant_sum <= HIGHEST_ABUNDANT_SUM]

sum <- sum(1:HIGHEST_ABUNDANT_SUM) - sum(abundant_sum)

cat(sum, fill=TRUE)
