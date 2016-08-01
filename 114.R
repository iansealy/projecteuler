# Counting block combinations I

library(memoise)

Args  <- commandArgs()
units <- ifelse(is.na(Args[6]), 50, as.numeric(Args[6]))

# Constants
MIN_BLOCK <- 3

ways <- memoise(function(total_length) {
    count <- 1

    if ( total_length < MIN_BLOCK ) {
        return(count)
    }

    for ( start in seq.int(0, total_length - MIN_BLOCK) ) {
        for ( block_length in seq.int(MIN_BLOCK, total_length - start) ) {
            count <- count + ways(total_length - start - block_length - 1)
        }
    }

    return(count)
})

cat(ways(units), fill=TRUE)
