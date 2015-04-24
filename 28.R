# Number spiral diagonals

Args  <- commandArgs()
width <- ifelse(is.na(Args[6]), 1001, as.numeric(Args[6]))

sum <- 1 # Middle number
current_width <- 1
increment <- 0
number <- 1

while ( current_width < width ) {
    current_width <- current_width + 2
    increment <- increment + 2
    for ( i in seq(4) ) {
        number <- number + increment
        sum <- sum + number
    }
}

cat(sum, fill=TRUE)
