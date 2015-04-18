# Reciprocal cycles

Args         <- commandArgs()
denominators <- ifelse(is.na(Args[6]), 999, as.numeric(Args[6]))

cycles <- sapply(seq.int(denominators), function(denominator) {
    remainder <- 1 %% denominator
    first_seen <- vector()
    digit <- 0
    while ( remainder ) {
        digit <- digit + 1
        remainder <- remainder * 10
        whole <- remainder %/% denominator
        remainder <- remainder %% denominator
        key <- paste0(whole, ':', remainder)
        if ( key %in% names(first_seen) ) {
            return(digit - first_seen[[key]])
        } else {
            first_seen[key] <- digit
        }
    }
    return(0)
})

cat(which.max(cycles), fill=TRUE)
