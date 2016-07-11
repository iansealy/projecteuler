# Primes with runs

library(gtools)

Args <- commandArgs()
n    <- ifelse(is.na(Args[6]), 10, as.numeric(Args[6]))

is_prime <- function(num) {
    if ( num == 1 ) { # 1 isn't prime
        return(FALSE)
    }
    if ( num < 4 ) { # 2 and 3 are prime
        return(TRUE)
    }
    if ( num %% 2 == 0 ) { # Even numbers aren't prime
        return(FALSE)
    }
    if ( num < 9 ) { # 5 and 7 are prime
        return(TRUE)
    }
    if ( num %% 3 == 0 ) { # Numbers divisible by 3 aren't prime
        return(FALSE)
    }

    num_sqrt <- as.integer(sqrt(num))
    factor <- 5
    while ( factor <= num_sqrt ) {
        if ( num %% factor == 0 ) { # Primes greater than three are 6k-1
            return(FALSE)
        }
        if ( num %% (factor + 2) == 0 ) { # Or 6k+1
            return(FALSE)
        }
        factor <- factor + 6
    }
    return(TRUE)
}

total <- 0
for ( d in seq.int(0, 9) ) {
    other_digits <- seq.int(0, 9)
    other_digits <- other_digits[other_digits != d]
    non_rep_digits <- 0
    while ( TRUE ) {
        non_rep_digits <- non_rep_digits + 1
        primes <- vector()
        base <- paste(rep(d, n), collapse='')
        combs <- combinations(n, non_rep_digits)
        for ( i in seq.int(nrow(combs)) ) {
            comb <- combs[i,]
            perms <- permutations(length(other_digits), non_rep_digits,
                                  v=other_digits, repeats.allowed=TRUE)
            for ( j in seq.int(nrow(perms)) ) {
                perm <- perms[j,]
                num <- base
                for ( k in seq.int(non_rep_digits) ) {
                    substr(num, comb[k], comb[k]) <- as.character(perm[k])
                }
                if ( substr(num, 1, 1) == '0' ) {
                    next
                }
                if ( is_prime(as.numeric(num)) ) {
                    primes <- c(primes, as.numeric(num))
                }
            }
        }
        if ( length(primes) ) {
            total <- total + sum(primes)
            break
        }
    }
}

cat(total, fill=TRUE)
