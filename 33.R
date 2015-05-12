# Digit cancelling fractions

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

num_product <- 1
denom_product <- 1

for ( num in seq.int(10, 98) ) {
    nums <- as.integer(strsplit(as.character(num), split=NULL)[[1]])
    for ( denom in seq.int(num + 1, 99) ) {
        denoms <- as.integer(strsplit(as.character(denom), split=NULL)[[1]])
        if ( denoms[2] == 0 ) {
            next
        }
        if ( (nums[1] == denoms[2] && nums[2] / denoms[1] == num / denom)
            || (nums[2] == denoms[1] && nums[1] / denoms[2] == num / denom) ) {
            num_product <- num_product * num
            denom_product <- denom_product * denom
        }
    }
}

primes <- get_primes_up_to(num_product)
for ( prime in primes ) {
    while ( num_product %% prime == 0 && denom_product %% prime == 0 ) {
        num_product <- num_product / prime
        denom_product <- denom_product / prime
    }
}

cat(denom_product, fill=TRUE)
