# Smallest multiple

Args    <- commandArgs()
max_num <- ifelse(is.na(Args[6]), 20, as.numeric(Args[6]))

get_primes <- function(limit) {
    primes <- c(2, 3)
    num <- 5

    while ( num <= limit ) {
        is_prime <- TRUE
        num_sqrt <- as.integer(sqrt(num))
        for (prime in primes) {
            if ( prime > num_sqrt ) {
                break
            }
            if ( num %% prime == 0 ) {
                is_prime <- FALSE
                break
            }
        }
        if ( is_prime ) {
            primes <- c(primes, num)
        }
        num <- num + 2
    }

    return(primes)
}

multiple <- 1

primes <- get_primes(max_num)

limit <- as.integer(sqrt(max_num))

for (prime in primes) {
    power <- 1
    if ( prime <= limit ) {
        power <- as.integer( log(max_num) / log(prime) )
    }
    multiple <- multiple * prime ^ power
}

cat(multiple, fill=TRUE)
