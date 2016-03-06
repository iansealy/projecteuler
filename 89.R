# Roman numerals

# Constants
ROMAN_URL <- 'https://projecteuler.net/project/resources/p089_roman.txt'
TO_DECIMAL <- c(1, 5, 10, 50, 100, 500, 1000)
names(TO_DECIMAL) <- c('I', 'V', 'X', 'L', 'C', 'D', 'M')
TO_ROMAN <- c(1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1)
names(TO_ROMAN) <- c('M', 'CM', 'D', 'CD', 'C', 'XC', 'L', 'XL', 'X', 'IX', 'V',
                     'IV', 'I')

to_decimal <- function(roman) {
    decimal <- 0

    while ( nchar(roman) ) {
        if ( grepl('^(IV|IX|XL|XC|CD|CM)', roman) ) {
            num1 <- substring(roman, 1, 1)
            num2 <- substring(roman, 2, 2)
            roman <- substring(roman, 3)
            decimal <- decimal + TO_DECIMAL[num2] - TO_DECIMAL[num1]
        } else {
            num <- substring(roman, 1, 1)
            roman <- substring(roman, 2)
            decimal <- decimal + TO_DECIMAL[num]
        }
    }

    return(decimal)
}

to_roman <- function(decimal) {
    roman <- vector()

    for ( i in seq.int(length(TO_ROMAN)) ) {
        quotient <- decimal %/% TO_ROMAN[i]
        if ( quotient ) {
            for ( j in seq.int(quotient) ) {
                roman <- c(roman, names(TO_ROMAN)[i])
            }
        }
        decimal <- decimal %% TO_ROMAN[i]
    }
    roman <- paste(roman, collapse='')

    return(roman)
}

non_minimal_numbers <- suppressWarnings(read.delim(sub('https', 'http',
                                                       ROMAN_URL), header=FALSE,
                                        colClasses='character'))[,1]

minimal_numbers <- vector()
for ( number in non_minimal_numbers ) {
    minimal_numbers <- c(minimal_numbers, to_roman(to_decimal(number)))
}
non_minimal_length <- sum(nchar(as.character(non_minimal_numbers)))
minimal_length <- sum(nchar(as.character(minimal_numbers)))

cat(non_minimal_length - minimal_length, fill=TRUE)
