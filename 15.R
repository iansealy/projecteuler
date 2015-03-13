# Lattice paths

Args      <- commandArgs()
grid_size <- ifelse(is.na(Args[6]), 20, as.numeric(Args[6]))

routes <- factorial(grid_size + grid_size) / factorial(grid_size)^2

cat(routes, fill=TRUE)
