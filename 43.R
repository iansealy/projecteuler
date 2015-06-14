# Sub-string divisibility

get_divisible_by <- function(divisor) {
    numbers <- vector()
    number <- 0
    while ( number + divisor < 1000 ) {
        number <- number + divisor
        str_number <- sprintf("%03d", number)
        num_uniq_digits <- length(unique(strsplit(str_number, split=NULL)[[1]]))
        if ( num_uniq_digits == nchar(str_number) ) {
            numbers <- c(numbers, str_number)
        }
    }

    return(numbers)
}

filter_not_pandigital <- function(candidates) {
    filtered <- vector()
    for ( candidate in candidates ) {
        num_uniq_digits <- length(unique(strsplit(candidate, split=NULL)[[1]]))
        if ( num_uniq_digits == nchar(candidate) ) {
            filtered <- c(filtered, candidate)
        }
    }

    return(filtered)
}

pandigitals <- vector()
multiples <- get_divisible_by(2)
for ( first in seq.int(0, 9) ) {
    pandigitals <- c(pandigitals, paste0(as.character(first), multiples))
}
pandigitals <- filter_not_pandigital(pandigitals)
for ( prime in c(3, 5, 7, 11, 13, 17) ) {
    multiples <- get_divisible_by(prime)
    prefixes <- substr(multiples, 1, 2)
    next_char <- substr(multiples, 3, 3)
    new_pandigitals <- vector()
    for ( pandigital in pandigitals ) {
        suffix <- substr(pandigital, nchar(pandigital) - 1, nchar(pandigital))
        next_chars <- next_char[prefixes == suffix]
        if ( length(next_chars) ) {
            new_pandigitals <- c(new_pandigitals,
                                 paste0(pandigital, next_chars))
        }
    }
    pandigitals <- filter_not_pandigital(new_pandigitals)
}

cat(sum(as.numeric(pandigitals)), fill=TRUE)
