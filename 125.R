# Palindromic sums

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 1e8, as.numeric(Args[6]))

is_palindrome <- function(number) {
    digit_chars <- strsplit(as.character(as.integer(number)), split=NULL)[[1]]
    reversed_number <- as.integer(paste(rev(digit_chars), collapse=''))
    if ( number == reversed_number ) {
        return(TRUE)
    } else {
        return(FALSE)
    }
}

squares <- 1
n <- 1
while ( squares[length(squares)] < limit ) {
    n <- n + 1
    squares <- c(squares, n * n)
}

palindromes <- vector()

for ( begin in seq.int(length(squares) - 1) ) {
    square_sum <- squares[begin]
    n <- begin + 1
    while ( n < length(squares) ) {
        square_sum <- square_sum + squares[n]
        if ( square_sum > limit ) {
            break
        }
        if ( is_palindrome(square_sum) ) {
            palindromes <- c(palindromes, square_sum)
        }
        n <- n + 1
    }
}

cat(sum(unique(palindromes)), fill=TRUE)
