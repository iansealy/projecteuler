# Integer right triangles

# Constants
MAX_SIDE <- 1000 / 2

side1 <- rep(1:MAX_SIDE, each=MAX_SIDE)
side2 <- rep(1:MAX_SIDE, MAX_SIDE)
side3 <- sqrt(side1*side1 + side2*side2)
total <- side1 + side2 + side3

integers <- total[side2 >= side1 & side3 == as.integer(side3)]

cat(names(rev(sort(table(integers))))[1], fill=TRUE)
