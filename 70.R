# Totient permutation

# Constants
LIMIT <- 1e7

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

sort_digits <- function(num) {
    return(paste(sort(strsplit(as.character(num), split=NULL)[[1]]),
                 collapse=""))
}

primes <- get_primes_up_to(2 * sqrt(LIMIT))

df <- expand.grid(prime1=primes, prime2=primes)
df$n <- df$prime1 * df$prime2
df$phi <- df$n * (1 - 1 / df$prime1) * (1 - 1 / df$prime2)
df$ratio <- df$n / df$phi

df$nsorted <- sapply(df$n, sort_digits)
df$phisorted <- sapply(df$phi, sort_digits)

min_ratio <- min(df$ratio[df$nsorted == df$phisorted & df$n < LIMIT])
n_for_min_ratio <- df$n[df$ratio == min_ratio]

cat(n_for_min_ratio[1], fill=TRUE)
