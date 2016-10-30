# Same differences

Args  <- commandArgs()
limit     <- ifelse(is.na(Args[6]), 1000000, as.numeric(Args[6]))
solutions <- ifelse(is.na(Args[7]), 10,      as.numeric(Args[7]))

# y = z + d
# x = z + 2d
# x^2 - y^2 - z^2 = n
# (z + 2d)^2 - (z + d)^2 - z^2 = n
# 3d^2 + 2dz - z^2 = n
count <- rep(0, limit)
for ( d in seq.int(limit) ) {
    z <- 0
    while ( z <= limit ) {
        z <- z + 1
        n <- 3 * d * d + 2 * d * z - z * z
        if ( n < 0 ) {
            break
        }
        if ( n > limit ) {
            sq_root <- sqrt((2 * d) * (2 * d) - 4 * (limit - 3 * d * d))
            z1 = floor((2 * d - sq_root) / 2)
            z2 = floor((2 * d + sq_root) / 2)
            if ( z1 > z ) {
                z <- z1 - 1
            } else if ( z2 > z ) {
                z <- z2 - 1
            }
            next
        }
        count[n] <- count[n] + 1
    }
}

cat(sum(count == solutions), fill=TRUE)
