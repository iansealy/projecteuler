# Amicable chains

# Constants
MAX <- 1000000

sum_proper_divisors <- rep(0, MAX)

for ( num in seq.int(MAX / 2) ) {
    for ( factor in seq.int(num * 2, MAX, num) ) {
        sum_proper_divisors[factor] <- sum_proper_divisors[factor] + num
    }
}

sum_proper_divisors[sum_proper_divisors >= MAX & sum_proper_divisors <= 2] <- NA
is_chain <- vector()

max_chain_length <- 0
max_chain_min_num <- 0
for ( num in which(sum_proper_divisors < MAX & sum_proper_divisors > 2) ) {
    got_chain <- TRUE
    chain <- c(num)
    while ( TRUE ) {
        next_num <- sum_proper_divisors[chain[length(chain)]]
        if ( is.na(next_num) ) {
            got_chain <- FALSE
            break
        }
        if ( next_num < num ) {
            got_chain <- FALSE
            break
        }
        if ( next_num == 0 ) {
            got_chain <- FALSE
            break
        }
        if ( chain[1] == next_num ) {
            break
        }
        if ( isTRUE(is_chain[next_num]) ) {
            got_chain <- FALSE
            break
        }
        if ( next_num %in% chain ) {
            got_chain <- FALSE
            break
        }
        chain <- c(chain, next_num)
    }
    if ( got_chain ) {
        is_chain[num] <- TRUE
        if ( length(chain) - 1 > max_chain_length ) {
            max_chain_length <- length(chain) - 1
            max_chain_min_num <- num
        }
    }
}

cat(max_chain_min_num, fill=TRUE)
