# Lexicographic permutations

Args    <- commandArgs()
digits  <- ifelse(is.na(Args[6]), 10,      as.numeric(Args[6]))
ordinal <- ifelse(is.na(Args[7]), 1000000, as.numeric(Args[7]))

permutation <- vector()
running_total <- 0
for (perm_digits_left in seq(digits, 1)) {
    num_in_batch <- factorial(perm_digits_left) / perm_digits_left
    for (digit in seq(0, digits - 1)) {
        if ( digit %in% permutation ) {
            next
        }
        if ( running_total + num_in_batch >= ordinal ) {
            permutation <- c(permutation, digit)
            break
        } else {
            running_total <- running_total + num_in_batch
        }
    }
}

cat(permutation, sep="", fill=TRUE)
