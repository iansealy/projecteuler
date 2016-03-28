# Almost equilateral triangles

# Constants
MAX <- 1e9

total <- 0

m <- 1
while ( TRUE ) {
    m <- m + 1
    m2 <- m * m
    df <- data.frame(n=seq.int(m - 1))
    df$parity <- (m + df$n) %% 2
    df <- df[df$parity == 1,]
    df$n2 <- df$n * df$n
    df$a <- m2 - df$n2
    df$b <- 2 * m * df$n
    df$c <- m2 + df$n2
    df$absa <- abs(2 * df$a - df$c)
    df$absb <- abs(2 * df$b - df$c)
    df <- df[df$absa == 1 | df$absb == 1,]
    df$perima <- 2 * (df$a + df$c)
    df$perimb <- 2 * (df$b + df$c)
    if ( sum(df$perima > MAX & df$perimb > MAX) ) {
        break
    }
    if ( sum(df$absa == 1) ) {
        total <- total + df$perima[df$absa == 1]
    }
    if ( sum(df$absb == 1) ) {
        total <- total + df$perimb[df$absb == 1]
    }
}

cat(total, fill=TRUE)
