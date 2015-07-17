# Combinatoric selections

# Constants
N <- 100

greater_count <- 0
r <- 0
n <- N
combs <- 1
while ( r < n / 2 ) {
    c_right <- combs * (n -r) / (r + 1)
    if ( c_right <= 1000000 ) {
        r <- r + 1
        combs <- c_right
    } else {
        c_up_right <- combs * (n - r) / n
        greater_count <- greater_count + n - 2 * r - 1
        n <- n - 1
        combs <- c_up_right
    }
}

cat(greater_count, fill=TRUE)
