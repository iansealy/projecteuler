# Pandigital multiples

max_pandigital <- 0
number <- 0
got_max <- FALSE
while (!got_max) {
    number <- number + 1
    if ( grepl('0', number) ) {
        next
    }
    n <- 1
    while ( TRUE ) {
        n <- n + 1
        concat_product <- as.character(number)
        for ( multiple in seq.int(2, n) ) {
            concat_product <- paste0(concat_product, multiple * number,
                                     collapse='')
        }
        if ( nchar(concat_product) < 9 ) {
            next
        }
        if ( nchar(concat_product) > 9 && n == 2 ) {
            got_max <- TRUE
            break
        }
        if ( nchar(concat_product) > 9 ) {
            break
        }
        if ( grepl('0', concat_product) ) {
            next
        }
        digits <- unique(as.integer(strsplit(concat_product, split=NULL)[[1]]))
        if ( length(digits) != 9 ) {
            next
        }
        if ( as.integer(concat_product) > max_pandigital ) {
            max_pandigital <- as.integer(concat_product)
        }
    }
}

cat(max_pandigital, fill=TRUE)
