# Cuboid route

Args  <- commandArgs()
target <- ifelse(is.na(Args[6]), 1000000, as.numeric(Args[6]))

total <- 0
m <- 1
m <- 3
while ( total < target ) {
    df <- expand.grid(i=seq.int(m), j=seq.int(m))
    df <- df[df$i >= df$j,]
    df$route <- sqrt((df$i + df$j) * (df$i + df$j) + m * m)
    df$introute <- as.integer(df$route)
    total <- total + sum(df$introute == df$route)
    m <- m + 1
}

cat(m - 1, fill=TRUE)
