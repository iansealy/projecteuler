# Powerful digit counts

options(scipen=100)

count <- 0
n <- 0
match_seen <- TRUE
while ( match_seen ) {
    n <- n + 1
    match_seen <- FALSE
    num <- 0
    power <- 0
    while ( nchar(as.character(power)) <= n ) {
        num <- num + 1
        power <- num ^ n
        if ( nchar(as.character(power)) == n ) {
            count <- count + 1
            match_seen <- TRUE
        }
    }
}

cat(count, fill=TRUE)
