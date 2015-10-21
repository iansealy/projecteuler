# Square root digital expansion

suppressPackageStartupMessages(library(gmp))

total <- 0
current_square <- 0
for ( num in seq.int(100) ) {
    if ( sqrt(num) == floor(sqrt(num)) ) {
        current_square <- num
        next
    }
    square_root <- as.bigz(sqrt(current_square))
    div <- (num - current_square) * 100
    while ( nchar(as.character(square_root)) < 100 ) {
        double <- square_root * 2
        i <- 0
        while ( TRUE ) {
            i <- i + 1
            if ( (double * 10 + i) * i > div ) {
                i <- i - 1
                break
            }
        }
        square_root <- square_root * 10 + i
        div <- (div - (double * 10 + i) * i) * 100
    }
    total <- total + sum(as.integer(strsplit(as.character(square_root),
                                             split=NULL)[[1]]))
}

cat(total, fill=TRUE)
