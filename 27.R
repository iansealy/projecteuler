# Quadratic primes

# Constants
MAX_A <- 999
MAX_B <- 999
PRIMES_LIMIT <- 1000000

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

primes <- get_primes_up_to(PRIMES_LIMIT)

df <- expand.grid(a=seq(-MAX_A, MAX_A), b=seq(-MAX_B, MAX_B))
df$primes <- TRUE

n <- 0
while ( sum(df$primes) > 1 ) {
    df$quadratic <- n * n + df$a * n + df$b
    df$primes <- df$quadratic %in% primes & df$primes
    n <- n + 1
}

cat(df[df$primes,]$a * df[df$primes,]$b, fill=TRUE)
