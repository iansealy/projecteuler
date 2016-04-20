# Square digit chains

# Constants
MAX <- 10000000

cache <- vector("integer", 9 * 9 * 7)
cache[1] <- 1
cache[89] <- 89

for ( num in seq.int(2, 9 * 9 * 7) ) {
    chain <- vector()
    final <- 1
    n <- num
    while ( TRUE ) {
        if ( cache[n] ) {
            final <- cache[n]
            break
        }
        chain <- c(chain, n)
        digits <- as.integer(strsplit(as.character(n), split=NULL)[[1]])
        n <- sum(digits * digits)
    }
    for ( n in chain ) {
        cache[n] <- final
    }
}

sumsquare <- function(x) {
    return(sum(x * x))
}

sums <- sapply(lapply(strsplit(as.character(seq.int(MAX)), split=NULL),
               as.integer), sumsquare)
count <- sum(sums %in% which(cache == 89))

cat(count, fill=TRUE)
