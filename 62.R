# Cubic permutations

Args  <- commandArgs()
perms <- ifelse(is.na(Args[6]), 5, as.numeric(Args[6]))

options(digits=22)

current_digits <- 1
num <- 0
cubes_for <- list()
lowest_cube <- NA
while ( is.na(lowest_cube) ) {
    num <- num + 1
    cube <- num ^ 3

    if ( current_digits < nchar(as.character(cube)) ) {
        # Check if finished
        for ( cubes in cubes_for ) {
            if ( length(cubes) == perms ) {
                low_cube <- min(cubes)
                if ( is.na(lowest_cube) || low_cube < lowest_cube ) {
                    lowest_cube <- low_cube
                }
            }
        }
        # Reset for another digit range
        current_digits <- nchar(as.character(cube))
        cubes_for <- list()
    }

    key <- paste(sort(strsplit(as.character(cube), split=NULL)[[1]]),
                 collapse="")
    cubes_for[[key]] <- c(cubes_for[[key]], cube)
}

cat(lowest_cube, fill=TRUE)
