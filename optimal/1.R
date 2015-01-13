# Multiples of 3 and 5

# Constants
MAX_NUM <- 1000

sum_sequence <- function(step) {
    last_int <- (MAX_NUM - 1) %/% step
    return(step * last_int * ( last_int + 1) / 2)
}

cat(sum_sequence(3) + sum_sequence(5) - sum_sequence(15), fill=TRUE)
