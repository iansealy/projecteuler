# Number letter counts

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 1000, as.numeric(Args[6]))

get_in_words <- function(num) {
    unit_for <- c('one', 'two', 'three', 'four', 'five', 'six', 'seven',
                  'eight', 'nine')
    teen_for <- c('eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen',
                  'sixteen', 'seventeen', 'eighteen', 'nineteen')
    tens_for <- c('ten', 'twenty', 'thirty', 'forty', 'fifty', 'sixty',
                  'seventy', 'eighty', 'ninety')

    # 1000 is only possible 4 digit number
    if ( num == 1000 ) {
        return('onethousand')
    }

    # Deal with 100s (don't require "and")
    if ( num %% 100 == 0 ) {
        return(paste0(unit_for[num / 100], 'hundred'))
    }

    words <- ''

    # Deal with 100s part of 3 digit number and leave 1 or 2 digit number
    if ( num > 100 ) {
        words <- paste0(words, unit_for[num %/% 100], 'hundredand')
        num <- num %% 100
    }

    # Numbers ending 01 to 09 (or just 1 to 9)
    if ( num < 10 ) {
        return(paste0(words, unit_for[num]))
    }

    # Numbers ending 10, 20 .. 80, 90
    if ( num %% 10 == 0 ) {
        return(paste0(words, tens_for[num / 10]))
    }

    # Numbers ending 11 to 19
    if ( num < 20 ) {
        return(paste0(words, teen_for[num - 10]))
    }

    # Remaining two digit numbers
    return(paste0(words, tens_for[num %/% 10], unit_for[num %% 10]))
}

sum <- 0
for (num in seq.int(limit)) {
    sum <- sum + nchar(get_in_words(num))
}

cat(sum, fill=TRUE)
