# Ordered fractions

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 1000000, as.numeric(Args[6]))

# Constants
TARGET_FRAC <- c(3, 7)

best_numer <- 0
best_denom <- 1
cur_denom <- limit
min_denom <- 1
while ( cur_denom >= min_denom ) {
    cur_numer <- (TARGET_FRAC[1] * cur_denom - 1) %/% TARGET_FRAC[2]
    if ( best_numer * cur_denom < cur_numer * best_denom ) {
        best_numer <- cur_numer
        best_denom <- cur_denom
        delta <- TARGET_FRAC[1] * cur_denom - TARGET_FRAC[2] * cur_numer
        min_denom <- cur_numer %/% delta + 1
    }
    cur_denom <- cur_denom - 1
}

cat(best_numer, fill=TRUE)
