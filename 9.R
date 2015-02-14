# Special Pythagorean triplet

# Constants
SUM <- 1000

get_pythagorean_triplet_by_sum <- function(target_sum) {
    a <- 1
    while ( a < target_sum - 2 ) {
        b <- a + 1
        while ( b < target_sum - 1 ) {
            c = sqrt( a * a + b * b )

            # Check if we have a Pythagorean triplet
            if ( isTRUE(all.equal(c, as.integer(c))) ) {
                if ( a + b + c == target_sum ) {
                    return( c(a, b, c) )
                }
            }

            b <- b + 1
        }
        a <- a + 1
    }

    return( c(0, 0, 0) )
}

triplet = get_pythagorean_triplet_by_sum( SUM )

cat(triplet[1] * triplet[2] * triplet[3], fill=TRUE)
