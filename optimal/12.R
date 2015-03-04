# Highly divisible triangular number

Args         <- commandArgs()
divisors     <- ifelse(is.na(Args[6]), 500,  as.numeric(Args[6]))
primes_limit <- ifelse(is.na(Args[7]), 1000, as.numeric(Args[7]))

get_primes_up_to <- function(limit) {
    sieve_bound <- (limit - 1) %/% 2 # Last index of sieve
    sieve <- rep(FALSE, sieve_bound)
    cross_limit <- (floor(sqrt(limit)) - 1) %/% 2

    i <- 1
    while (i <= cross_limit) {
        if (!sieve[i]) {
            # 2 * $i + 1 is prime, so mark multiples
            j <- 2 * i * (i + 1)
            while (j <= sieve_bound) {
                sieve[j] <- TRUE
                j <- j + 2 * i + 1
            }
        }
        i <- i + 1
    }

    primes <- rep(0, sieve_bound)
    for (i in seq(1, sieve_bound)) {
        if (!sieve[i]) {
            primes[i] <- 2 * i + 1
        }
    }

    return(c(2, primes[primes > 0]))
}

primes <- get_primes_up_to(primes_limit)

# Triangle numbers are of form n*(n+1)*2
# D() = number of divisors
# D(triangle number) = D(n/2)*D(n+1) if n is even
#                   or D(n)*D((n+1)/2) if n+1 is even

n <- 3  # Start with a prime
num_divisors_n <- 2  # Always 2 for a prime
num_factors <- 0

while ( num_factors <= divisors ) {
    n <- n + 1
    n1 <- n
    if ( n1 %% 2 == 0 ) {
        n1 <- n1 / 2
    }
    num_divisors_n1 <- 1

    for (prime in primes) {
        if ( prime * prime > n1 ) {
            # Got last prime factor with exponent of 1
            num_divisors_n1 <- num_divisors_n1 * 2
            break
        }

        exponent <- 1
        while ( n1 %% prime == 0 ) {
            exponent <- exponent + 1
            n1 <- n1 / prime
        }
        if ( exponent > 1 ) {
            num_divisors_n1 <- num_divisors_n1 * exponent
        }
        if ( n1 == 1 ) {
            break
        }
    }

    num_factors <- num_divisors_n * num_divisors_n1
    num_divisors_n <- num_divisors_n1
}

cat(n * ( n - 1 ) / 2, fill=TRUE)
