# Cuboid layers

Args    <- commandArgs()
cuboids <- ifelse(is.na(Args[6]), 1000, as.numeric(Args[6]))

count_cuboids <- function(x, y, z, n) {
    count <- 2 * (x * y + y * z + z * x) +
        (n - 1) * 4 * (x + y + z) +
        (n - 2) * (n - 1) * 4
    return(count)
}

first <- NA
limit <- cuboids * 10
while ( is.na(first) ) {
    limit <- limit * 2
    count <- rep(0, limit)
    for ( x in seq.int(limit) ) {
        if ( count_cuboids(x, 1, 1, 1) >= limit ) {
            break
        }
        for ( y in seq.int(x) ) {
            if ( count_cuboids(x, y, 1, 1) >= limit ) {
                break
            }
            for ( z in seq.int(y) ) {
                if ( count_cuboids(x, y, z, 1) >= limit ) {
                    break
                }
                for ( n in seq.int(limit) ) {
                    total <- count_cuboids(x, y, z, n)
                    if ( total >= limit ) {
                        break
                    }
                    count[total] <- count[total] + 1
                }
            }
        }
    }
    first <- which(count == cuboids)[1]
}

cat(first, fill=TRUE)
