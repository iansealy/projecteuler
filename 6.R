# Smallest multiple

Args    <- commandArgs()
max_num <- ifelse(is.na(Args[6]), 100, as.numeric(Args[6]))

sum_squares <- sum((1:max_num)^2)
square_sum  <- sum(1:max_num)^2

cat(square_sum - sum_squares, fill=TRUE)
