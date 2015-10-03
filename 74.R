# Digit factorial chains

# Constants
LIMIT <- 1000000
TARGET <- 60

factorials <- factorial(0:9)

chain_length_for <- new.env(hash=TRUE)
target_count <- 0
for ( num in seq.int(0, LIMIT - 1) ) {
    # Check cache
    sorted_digits <- paste(sort(strsplit(as.character(num), split=NULL)[[1]]),
                           collapse="")
    if ( exists(sorted_digits, chain_length_for) ) {
        if ( get(sorted_digits, chain_length_for) == TARGET ) {
            target_count <- target_count + 1
        }
        next
    }

    chain_length <- 1
    chain_num <- num
    seen <- vector()
    while ( TRUE ) {
        digits <- as.integer(strsplit(as.character(chain_num), split=NULL)[[1]])
        chain_num <- 0
        for ( digit in digits ) {
            chain_num <- chain_num + factorials[digit + 1]
        }
        if ( chain_num %in% seen ) {
            break
        }
        seen <- c(seen, chain_num)
        chain_length <- chain_length + 1
    }

    # Cache
    assign(as.character(num), chain_length, chain_length_for)
    if ( chain_length == TARGET ) {
        target_count <- target_count + 1
    }
}

cat(target_count, fill=TRUE)
