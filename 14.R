# Longest Collatz sequence

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 1000000, as.numeric(Args[6]))

longest_chain_length <- 0
longest_chain_start  <- 1

for ( start in seq(2, limit) ) {
    length <- 0
    number <- start
    while ( number > 1 ) {
        length <- length + 1
        if ( number %% 2 ) {
            number <- 3 * number + 1
        } else {
            number <- number / 2
        }
    }
    if ( length > longest_chain_length ) {
        longest_chain_length <- length
        longest_chain_start  <- start
    }
}

cat(longest_chain_start, fill=TRUE)
