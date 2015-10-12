# Prime summations

library(memoise)

Args   <- commandArgs()
minimum <- ifelse(is.na(Args[6]), 5001, as.numeric(Args[6]))

ways <- memoise(function(total, numbers) {
    if ( total < 0 ) {
        return(0)
    }
    if ( total == 0 ) {
        return(1)
    }

    count <- 0
    while ( !is.na(numbers[1]) ) {
        count <- count + ways(total - numbers[1], numbers)
        numbers <- numbers[2:length(numbers)]
    }

    return(count)
})

get_primes_up_to <- function(limit) {
    sieve_bound <- (limit - 1) %/% 2 # Last index of sieve
    sieve <- rep(FALSE, sieve_bound)
    cross_limit <- (floor(sqrt(limit)) - 1) %/% 2

    i <- 1
    while ( i <= cross_limit ) {
        if (!sieve[i]) {
            # 2 * $i + 1 is prime, so mark multiples
            j <- 2 * i * (i + 1)
            while ( j <= sieve_bound ) {
                sieve[j] <- TRUE
                j <- j + 2 * i + 1
            }
        }
        i <- i + 1
    }

    primes <- rep(0, sieve_bound)
    for ( i in seq(1, sieve_bound) ) {
        if ( !sieve[i] ) {
            primes[i] <- 2 * i + 1
        }
    }

    return(c(2, primes[primes > 0]))
}

n <- 0
prime_limit <- 1
num_ways <- 0
while ( num_ways < minimum ) {
    n <- n + 1
    if ( n == prime_limit ) {
        primes <- get_primes_up_to(n * 10)
        prime_limit <- n * 10
    }
    num_ways <- ways(n, primes[primes < n])
}

cat(n, fill=TRUE)
