# Maximum path sum II

# Constants
TRIANGLE_URL <- 'https://projecteuler.net/project/resources/p067_triangle.txt'

raw_input <- suppressWarnings(read.delim(sub('https', 'http', TRIANGLE_URL),
                                         header=FALSE, sep='X',
                                         colClasses='character'))

num_layers <- nrow(raw_input)
triangle <- vector(mode="list", length=num_layers)
i <- 0
for ( layer in raw_input[,1] ) {
    i <- i + 1
    triangle[[i]] <- as.integer(strsplit(layer, " ")[[1]])
}

for ( i in rev(seq.int(num_layers - 1)) ) {
    for ( j in seq.int(i) ) {
        max_parent <- max(triangle[[i+1]][j], triangle[[i+1]][j+1])
        triangle[[i]][j] <- triangle[[i]][j] + max_parent
    }
}

cat(triangle[[1]][1], fill=TRUE)
