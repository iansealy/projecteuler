# Amicable numbers

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 10000, as.numeric(Args[6]))

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

sum <- 0

for (a in seq.int(2, limit-1)) {
    b <- sum_proper_divisors(a)
    if ( b > a ) {
        if ( sum_proper_divisors(b) == a ) {
            sum <- sum + a + b
        }
    }
}

cat(sum, fill=TRUE)
