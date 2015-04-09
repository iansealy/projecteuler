# Amicable numbers

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 10000, as.numeric(Args[6]))

sum_proper_divisors <- function(number) {
    sum <- 1

    for (i in seq.int(2, as.integer(sqrt(number)))) {
        if ( number %% i == 0 ) {
            sum <- sum + i + number %/% i
        }
    }

    return(sum)
}

divisor_sum <- sapply(seq.int(limit-1), sum_proper_divisors)

sum <- 0

for (num in seq.int(2, limit-1)) {
    if ( divisor_sum[num] >= limit || divisor_sum[num] == num ) {
        next
    }
    if ( divisor_sum[divisor_sum[num]] == num ) {
        sum <- sum + num
    }
}

cat(sum, fill=TRUE)
