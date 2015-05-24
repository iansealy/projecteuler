# Double-base palindromes

# Constants
MAX <- 1000000

make_palindrome_base_2 <- function(number, odd_length) {
    result <- number

    if ( odd_length ) {
        number <- bitwShiftR(number, 1)
    }

    while ( number > 0 ) {
        result <- bitwShiftL(result, 1) + bitwAnd(number, 1)
        number <- bitwShiftR(number, 1)
    }

    return(result)
}

is_palindrome <- function(number, base) {
    reversed <- 0
    k <- number
    while ( k > 0 ) {
        reversed <- base * reversed + k %% base
        k <- k %/% base
    }

    return(number == reversed)
}

total <- 0
i <- 1
p <- make_palindrome_base_2(i, 1)
while ( p < MAX ) {
    if ( is_palindrome(p, 10) ) {
        total <- total + p
    }
    i <- i + 1
    p <- make_palindrome_base_2(i, 1)
}
i <- 1
p <- make_palindrome_base_2(i, 0)
while ( p < MAX ) {
    if ( is_palindrome(p, 10) ) {
        total <- total + p
    }
    i <- i + 1
    p <- make_palindrome_base_2(i, 0)
}

cat(total, fill=TRUE)
