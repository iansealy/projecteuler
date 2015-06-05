# Champernowne's constant

get_digit <- function(n) {
    num_digits <- 1
    range_start <- 1
    range_end <- 9
    while ( range_end < n ) {
        num_digits <- num_digits + 1
        range_start <- range_end + 1
        range_end <- range_end + num_digits * 9 * 10 ^ (num_digits - 1)
    }
    range_ordinal <- (n - range_start) %/% num_digits
    first_in_range <- 10 ^ (num_digits - 1)
    number <- first_in_range + range_ordinal
    digit_ordinal <- range_ordinal %% num_digits
    digit <- as.integer((strsplit(as.character(number),
                                  split=NULL)[[1]])[digit_ordinal + 1])
    return(digit)
}

product <- get_digit(1) * get_digit(10) * get_digit(100) * get_digit(1000) *
    get_digit(10000) * get_digit(100000) * get_digit(1000000)

cat(product, fill=TRUE)
