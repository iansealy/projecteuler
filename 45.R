# Triangular, pentagonal, and hexagonal

# Constants
KNOWN <- 40755

limit <- 10000
number_count <- new.env(hash=TRUE)
assign(as.character(KNOWN), -1, number_count)
n <- c(1, 1, 1)
last_number <- c(1, 1, 1)
functions <- list(
    function(n) {n * (n + 1) / 2},
    function(n) {n * (3 * n - 1) / 2},
    function(n) {n * (2 * n - 1)}
)
matching <- vector()

while ( !length(matching) ) {
    limit <- limit * 10
    for ( i in seq.int(3) ) {
        while ( last_number[i] < limit ) {
            n[i] <- n[i] + 1
            last_number[i] <- functions[[i]](n[i])
            if ( !exists(as.character(last_number[i]), number_count) ) {
                assign(as.character(last_number[i]), 0, number_count)
            }
            prev <- get(as.character(last_number[i]), number_count)
            assign(as.character(last_number[i]), prev + 1, number_count)
            if ( prev + 1 == 3 ) {
                matching <- c(matching, last_number[i])
            }
        }
    }
}

cat(sort(matching[1]), fill=TRUE)
