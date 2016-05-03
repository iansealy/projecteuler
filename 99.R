# Largest exponential

# Constants
EXP_URL <- 'https://projecteuler.net/project/resources/p099_base_exp.txt'

numbers <- read.csv(sub('https', 'http', EXP_URL), header=FALSE)
numbers[,3] <- numbers[,2] * log(numbers[,1])

cat(which(numbers[,3] == max(numbers[,3])), fill=TRUE)
