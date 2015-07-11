# Permuted multiples

num <- 0
while (TRUE) {
    num <- num + 1
    if ( strsplit(as.character(num), split=NULL)[[1]][1] != "1" ) {
        next
    }
    digits <- paste(sort(strsplit(as.character(num), split=NULL)[[1]]),
                    collapse="")
    all_match <- TRUE
    for ( multiple in seq.int(2, 6) ) {
        multiple_digits <- paste(sort(strsplit(as.character(num * multiple),
                                               split=NULL)[[1]]), collapse="")
        if ( digits != multiple_digits ) {
            all_match <- FALSE
            break
        }
    }
    if ( all_match ) {
        break
    }
}

cat(num, fill=TRUE)
