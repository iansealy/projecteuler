# Double-base palindromes

suppressPackageStartupMessages(library(R.utils))

# Constants
MAX <- 1000000

is_dec_bin_palindrome <- function(dec) {
    rev_dec <- as.integer(paste(rev(strsplit(as.character(dec),
                                             split=NULL)[[1]]), collapse=''))
    if ( dec != rev_dec ) {
        return(FALSE)
    }
    bin <- intToBin(dec)
    rev_bin <- paste(rev(strsplit(bin, split=NULL)[[1]]), collapse='')
    if ( bin != rev_bin ) {
        return(FALSE)
    }
    return(TRUE)
}

numbers <- seq.int(MAX - 1)
palindromes <- sapply(numbers, is_dec_bin_palindrome)

cat(sum(numbers[palindromes]), fill=TRUE)
