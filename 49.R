# Prime permutations

# Constants
KNOWN <- "148748178147"

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

primes <- get_primes_up_to(9999)
primes <- primes[primes >= 1000]

perm_group <- list()
for ( prime in primes ) {
    ordered_digits <- paste(sort(strsplit(as.character(prime),
                                          split=NULL)[[1]]), collapse="")
    perm_group[[ordered_digits]] <- c(perm_group[[ordered_digits]], prime)
}

groups <- list()
for ( group in names(perm_group) ) {
    if ( length(perm_group[[group]]) >= 3 ) {
        groups[[group]] <- perm_group[[group]]
    }
}

output <- NA

for ( group in names(groups) ) {
    group3s <- combn(groups[[group]], 3, simplify=FALSE)
    for ( group3 in group3s ) {
        if ( group3[2] - group3[1] == group3[3] - group3[2] ) {
            concat <- paste(group3, collapse="")
            if ( concat != KNOWN ) {
                output <- concat
            }
        }
    }
}

cat(output, fill=TRUE)
