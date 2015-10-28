# Path sum: three ways

Args <- commandArgs()
url  <- ifelse(is.na(Args[6]),
               'https://projecteuler.net/project/resources/p082_matrix.txt',
               as.character(Args[6]))

matrix <- data.matrix(read.csv(url, header=FALSE, colClasses='character'))

s <- matrix

for ( j in seq.int(2, ncol(s)) ) {
    s[1,j] = s[1,j-1] + matrix[1,j]
    for ( i in seq.int(2, nrow(s)) ) {
        if ( s[i,j-1] < s[i-1,j] ) {
            s[i,j] <- s[i,j-1] + matrix[i,j]
        } else {
            s[i,j] <- s[i-1,j] + matrix[i,j]
        }
    }
    for ( i in seq.int(nrow(s) - 1, 1) ) {
        if ( s[i,j] > s[i+1,j] + matrix[i,j] ) {
            s[i,j] <- s[i+1,j] + matrix[i,j]
        }
    }
}

cat(min(s[,ncol(s)]), fill=TRUE)
