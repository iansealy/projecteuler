# Pandigital Fibonacci ends

# Constants
TRUNCATE  <- 1e10
LOG_PHI   <- log10((1 + sqrt(5)) / 2)
LOG_ROOT5 <- log10(5) / 2

is_pandigital <- function(num) {
    num <- as.character(num)
    num_uniq_digits <- length(unique(strsplit(num, split=NULL)[[1]]))
    if ( num_uniq_digits == nchar(num) ) {
        return(TRUE)
    } else {
        return(FALSE)
    }
}

k <- 2
fib1 <- 1
fib2 <- 1
while ( TRUE ) {
    k <- k + 1
    fib3 <- fib1 + fib2
    fib1 <- fib2 %% TRUNCATE
    fib2 <- fib3 %% TRUNCATE
    if ( !is_pandigital(fib2) ) {
        next
    }
    log_fibk <- k * LOG_PHI - LOG_ROOT5
    fibk <- floor(10 ^ (log_fibk - floor(log_fibk)) * 10 ^ 8)
    if ( is_pandigital(fibk) ) {
        break
    }
}

cat(k, fill=TRUE)
