# Composites with prime repunit property

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 25, as.numeric(Args[6]))

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

composite <- vector()
n <- 90
while ( length(composite) < limit ) {
    n <- n + 1
    if ( n %% 2 == 0 || n %% 5 == 0 || is_prime(n) ) {
        next
    }
    rkmodn <- 1
    k <- 1
    while ( rkmodn %% n != 0 ) {
        k <- k + 1
        rkmodn <- (rkmodn * 10 + 1) %% n
    }
    if ( (n - 1) %% k != 0 ) {
        next
    }
    composite <- c(composite, n)
}

cat(sum(composite), fill=TRUE)
