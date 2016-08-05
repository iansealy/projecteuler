# Red, green or blue tiles

library(memoise)

Args  <- commandArgs()
units <- ifelse(is.na(Args[6]), 50, as.numeric(Args[6]))

# Constants
BLOCK_SIZES <- c(2, 3, 4)

ways <- memoise(function(total_length, block_size) {
    count <- 1

    if ( total_length < block_size ) {
        return(count)
    }

    for ( start in seq.int(0, total_length - block_size) ) {
        count <- count + ways(total_length - start - block_size, block_size)
    }

    return(count)
})

total <- 0
for ( block_size in BLOCK_SIZES ) {
    total <- total + ways(units, block_size) - 1
}

cat(total, fill=TRUE)
