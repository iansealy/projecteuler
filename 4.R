# Largest palindrome product

Args   <- commandArgs()
digits <- ifelse(is.na(Args[6]), 3, as.numeric(Args[6]))

high_num <- 10 ^ digits - 1

keep_palindrome <- function(number) {
    digit_chars <- strsplit(as.character(as.integer(number)), split=NULL)[[1]]
    reversed_number <- as.integer(paste(rev(digit_chars), collapse=''))
    if ( number == reversed_number ) {
        return(number)
    } else {
        return(0)
    }
}

products <- 1:high_num %*% t(1:high_num)
palindromic_products <- apply(products, c(1,2), keep_palindrome)

cat(max(palindromic_products), fill=TRUE)
