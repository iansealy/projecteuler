# Even Fibonacci numbers

# Constants
MAX_FIB <- 4000000

fib_even <- c(0, 2)
sum_even <- 0

while ( fib_even[2] < MAX_FIB ) {
    fib_even <- c( fib_even[2], 4 * fib_even[2] + fib_even[1] )
    sum_even <- sum_even + fib_even[1]
}

cat(sum_even, fill=TRUE)
