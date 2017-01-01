# Pythagorean tiles

# Constants
LIMIT <- 100000000

# Get greatest common divisor
gcd <- function(a, b) {
    r <- a %% b;

    return(ifelse(r, gcd(b, r), b))
}

count <- 0
mlimit <- floor(sqrt(LIMIT))
for ( m in seq.int(2, mlimit) ) {
    m2 <- m * m
    df <- data.frame(n=seq.int(m - 1))
    df$parity <- (m + df$n) %% 2
    df <- df[df$parity == 1,]
    df$gcd <- gcd(df$n, m)
    df <- df[df$gcd == 1,]
    df$n2 <- df$n * df$n
    df$a <- m2 - df$n2
    df$b <- 2 * m * df$n
    df$c <- m2 + df$n2
    df$perimeter <- df$a + df$b + df$c
    df <- df[df$perimeter < LIMIT,]
    df$tiling <- df$c %% (df$b - df$a)
    df <- df[df$tiling == 0,]
    for ( perimeter in df$perimeter ) {
        count <- count + LIMIT %/% perimeter
    }
}

cat(count, fill=TRUE)
