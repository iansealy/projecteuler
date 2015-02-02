# Smallest multiple

Args    <- commandArgs()
max_num <- ifelse(is.na(Args[6]), 100, as.numeric(Args[6]))

sum_squares <- ( 2 * max_num + 1 ) * ( max_num + 1 ) * max_num / 6
square_sum = ( max_num * ( max_num + 1 ) / 2 )^2;

cat(square_sum - sum_squares, fill=TRUE)
