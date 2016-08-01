# Counting block combinations II

library(memoise)

Args <- commandArgs()
m    <- ifelse(is.na(Args[6]), 50, as.numeric(Args[6]))

# Constants
TARGET <- 1000000

ways <- memoise(function(min_block, total_length) {
    count <- 1

    if ( total_length < min_block ) {
        return(count)
    }

    for ( start in seq.int(0, total_length - min_block) ) {
        for ( block_length in seq.int(min_block, total_length - start) ) {
            count <- count + ways(min_block,
                                  total_length - start - block_length - 1)
        }
    }

    return(count)
})

n <- m + 1
while ( ways(m, n) <= TARGET ) {
    n <- n + 1
}

cat(n, fill=TRUE)
