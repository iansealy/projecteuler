# Self powers

options(scipen=14)

# Constants
NUM_DIGITS <- 10
LAST_NUMBER <- 1000

sum_end <- 0
for ( number in seq.int(LAST_NUMBER) ) {
    power_end <- number
    for ( i in seq.int(number - 1) ) {
        power_end <- as.character(power_end * number)
        power_end <- as.numeric(substr(power_end,
            nchar(power_end) - NUM_DIGITS + 1, nchar(power_end) ))
    }
    sum_end <- as.character(sum_end + power_end)
    sum_end <- as.numeric(substr(sum_end,
        nchar(sum_end) - NUM_DIGITS + 1, nchar(sum_end) ))
}

cat(sprintf("%010.0f", sum_end), fill=TRUE)
