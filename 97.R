# Large non-Mersenne prime

# Constants
POWER <- 7830457
MULTIPLIER <- 28433
DIGITS <- 1e10

num <- 1
for ( i in seq.int(POWER) ) {
    num <- num * 2
    num <- num %% DIGITS
}

num <- num * MULTIPLIER
num <- num + 1
num <- num %% DIGITS

cat(num, fill=TRUE)
