# Longest Collatz sequence

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 1000000, as.numeric(Args[6]))

ints <- seq.int(limit)
in_chain <- ints > 1

while ( sum(in_chain) > 1 ) {
    odds <- which(ints %% 2 == 1)
    evens <- which(ints %% 2 == 0)
    ints[odds] <- 3 * ints[odds] + 1
    ints[evens] <- ints[evens] / 2
    in_chain <- in_chain & ints > 1
}

cat(which(in_chain), fill=TRUE)
