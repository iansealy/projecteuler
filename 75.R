# Singular integer right triangles

# Constants
LIMIT <- 1500000

# Get greatest common divisor
gcd <- function(a, b) {
    if ( a > b ) {
        a.tmp <- a
        a <- b
        b <- a.tmp
    }

    while ( a ) {
        a.tmp <- a
        a <- b %% a
        b <- a.tmp
    }

    return(b)
}

count <- rep(0, LIMIT)
mlimit <- floor(sqrt(LIMIT))
for ( m in seq.int(2, mlimit) ) {
    for ( n in seq.int(1, m - 1) ) {
        if ( (m + n) %% 2 == 0 || gcd(n, m) > 1 ) {
            next
        }
        len <- 2 * m * (m + n)
        multiple <- len
        while ( multiple <= LIMIT ) {
            count[multiple] <- count[multiple] + 1
            multiple <- multiple + len
        }
    }
}

cat(sum(count == 1), fill=TRUE)
