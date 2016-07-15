# Bouncy numbers

options(scipen=100)

Args       <- commandArgs()
proportion <- ifelse(is.na(Args[6]), 99, as.numeric(Args[6]))

is_bouncy <- function(num) {
    digits <- as.integer(strsplit(as.character(num), split=NULL)[[1]])
    seen_up <- FALSE
    seen_down <- FALSE
    for ( i in seq.int(2, length(digits)) ) {
        if ( digits[i] > digits[i - 1] ) {
            seen_up <- TRUE
        } else if ( digits[i] < digits[i - 1] ) {
            seen_down <- TRUE
        }
        if ( seen_up && seen_down ) {
            return(TRUE)
        }
    }
    return(FALSE)
}

total <- 100
bouncy <- 0
while ( bouncy / total * 100 != proportion ) {
    total <- total + 1
    if ( is_bouncy(total) ) {
        bouncy <- bouncy + 1
    }
}

cat(total, fill=TRUE)
