# Path sum: two ways

Args <- commandArgs()
url  <- ifelse(is.na(Args[6]),
               'https://projecteuler.net/project/resources/p081_matrix.txt',
               as.character(Args[6]))

matrix <- data.matrix(read.csv(url, header=FALSE, colClasses='character'))

s <- matrix(Inf, nrow(matrix) + 1, ncol(matrix) + 1)
s[2,1] <- 0
s[1,2] <- 0

for ( i in seq.int(2, nrow(s)) ) {
    for ( j in seq.int(2, ncol(s)) ) {
        s[i,j] <- matrix[i-1,j-1]
        if ( s[i-1,j] < s[i,j-1] ) {
            s[i,j] <- s[i,j] + s[i-1,j]
        } else {
            s[i,j] <- s[i,j] + s[i,j-1]
        }
    }
}

cat(s[nrow(s),ncol(s)], fill=TRUE)
