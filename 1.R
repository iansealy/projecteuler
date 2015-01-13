# Multiples of 3 and 5

# Constants
MAX_NUM <- 1000

seq <- 1:MAX_NUM-1
cat(sum(seq[ seq %% 3 == 0 | seq %% 5 == 0] ), fill=TRUE)
