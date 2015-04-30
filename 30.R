# Digit fifth powers

Args  <- commandArgs()
power <- ifelse(is.na(Args[6]), 5, as.numeric(Args[6]))

total_sum <- 0

max_per_digit <- 9 ^ power
max_digits <- 1
while ( max_digits * max_per_digit > as.numeric(paste(rep(9, max_digits),
                                                      collapse='')) ) {
    max_digits <- max_digits + 1
}

number <- 2
max_number <- 10 ^ max_digits
while ( number < max_number ) {
    digits <- as.integer(strsplit(as.character(number), split=NULL)[[1]])
    sum <- sum(digits ^ power)
    if ( sum == number ) {
        total_sum <- total_sum + number
    }
    number <- as.integer(number + 1)
}

cat(total_sum, fill=TRUE)
