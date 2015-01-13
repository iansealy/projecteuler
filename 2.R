# Even Fibonacci numbers

# Constants
MAX_FIB <- 4000000

fib <- c(1, 1)
sum_even <- 0

while ( fib[1] < MAX_FIB ) {
    fib <- c( fib[2], fib[1] + fib[2] )
    if ( fib[1] %% 2 == 0 ) {
        sum_even <- sum_even + fib[1]
    }
}

cat(sum_even, fill=TRUE)
