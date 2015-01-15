# Largest prime factor

Args   <- commandArgs()
number <- ifelse(is.na(Args[6]), 600851475143, as.numeric(Args[6]))

div <- 2

while ( div <= as.integer(sqrt(number)) ) {
    while ( number %% div == 0 ) {
        number = number / div
    }

    # Don't bother testing even numbers (except two)
    if ( div > 2 ) {
        div <- div + 2
    }
    else {
        div <- div + 1
    }
}

cat(number, fill=TRUE)
