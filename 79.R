# Passcode derivation

# Constants
TRIPLETS_URL <- 'https://projecteuler.net/project/resources/p079_keylog.txt'

triplets <- suppressWarnings(read.delim(sub('https', 'http', TRIPLETS_URL),
                                        header=FALSE, colClasses='character'))

after <- list()
for ( triplet in triplets[,1] ) {
    digits <- strsplit(triplet, split=NULL)[[1]]
    if ( !(digits[2] %in% after[[digits[1]]]) ) {
        after[[digits[1]]] <- c(after[[digits[1]]], digits[2])
    }
    if ( !(digits[3] %in% after[[digits[1]]]) ) {
        after[[digits[1]]] <- c(after[[digits[1]]], digits[3])
    }
    if ( !(digits[3] %in% after[[digits[2]]]) ) {
        after[[digits[2]]] <- c(after[[digits[2]]], digits[3])
    }
    if ( !(digits[3] %in% names(after)) ) {
        after[[digits[3]]] <- vector()
    }
}

for ( digit in names(after) ) {
    after[[digit]] <- length(after[[digit]])
}

cat(paste(names(sort(unlist(after), decreasing=TRUE)), collapse=''), fill=TRUE)
