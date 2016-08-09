# Red, green, and blue tiles

library(memoise)

options(scipen=100)

Args  <- commandArgs()
units <- ifelse(is.na(Args[6]), 50, as.numeric(Args[6]))

# Constants
BLOCK_SIZES <- c(2, 3, 4)

ways <- memoise(function(total_length) {
    count <- 1

    if ( total_length < BLOCK_SIZES[1] ) {
        return(count)
    }

    for ( block_size in BLOCK_SIZES ) {
        if ( total_length - block_size < 0 ) {
            break
        }
        for ( start in seq.int(0, total_length - block_size) ) {
            count <- count + ways(total_length - start - block_size)
        }
    }

    return(count)
})

cat(ways(units), fill=TRUE)
