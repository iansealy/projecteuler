# Cuboid route

Args  <- commandArgs()
target <- ifelse(is.na(Args[6]), 1000000, as.numeric(Args[6]))

total <- 0
m <- 1
while ( total < target ) {
    for ( ij in seq.int(2 * m) ) {
        route = sqrt(ij * ij + m * m)
        if ( as.integer(route) == route ) {
            if ( ij <= m ) {
                total <- total + ij %/% 2
            } else {
                total <- total + m - (ij + 1) %/% 2 + 1
            }
        }
    }
    m <- m + 1
}

cat(m - 1, fill=TRUE)
