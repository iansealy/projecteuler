# Prime power triples

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 50000000, as.numeric(Args[6]))

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

primes <- get_primes_up_to(floor(sqrt(limit)))

squares <- primes * primes
cubes <- squares * primes
fourths <- cubes * primes
squares <- squares[squares < limit]
cubes <- cubes[cubes < limit]
fourths <- fourths[fourths < limit]

df <- expand.grid(squares=squares, cubes=cubes, fourths=fourths)
df$sum <- df$squares + df$cubes + df$fourths
sums <- unique(df$sum[df$sum < limit])

cat(length(sums), fill=TRUE)
