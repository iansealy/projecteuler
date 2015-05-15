# Digit factorials

numbers <- 10:(factorial(9) * 7)

same <- sapply(numbers, function(i) {
    sum(factorial(as.integer(strsplit(as.character(i), split=NULL)[[1]]))) == i
})

cat(sum(numbers[same]), fill=TRUE)
