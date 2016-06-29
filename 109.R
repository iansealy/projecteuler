# Darts

# Constants
SINGLES <- c(1:20, 25)
DOUBLES <- SINGLES * 2
TREBLES <- c(1:20) * 3
ALL <- sort(c(SINGLES, DOUBLES, TREBLES))
MAX <- 99
UPPER <- 170

ways <- rep(0, UPPER)

# One dart
for ( double in DOUBLES ) {
    ways[double] <- ways[double] + 1
}

# Two darts
for ( dart1 in ALL ) {
    for ( double in DOUBLES ) {
        ways[dart1 + double] <- ways[dart1 + double] + 1
    }
}

# Three darts
for ( idx1 in seq.int(length(ALL)) ) {
    for ( idx2 in seq.int(idx1, length(ALL)) ) {
        for ( double in DOUBLES ) {
            ways[ALL[idx1] + ALL[idx2] + double] <-
                ways[ALL[idx1] + ALL[idx2] + double] + 1
        }
    }
}

cat(sum(ways[1:MAX]), fill=TRUE)
