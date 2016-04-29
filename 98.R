# Anagramic squares

options(scipen=100)

# Constants
WORDS_URL <- 'https://projecteuler.net/project/resources/p098_words.txt'

words <- suppressWarnings(read.csv(sub('https', 'http', WORDS_URL),
                                   header=FALSE, colClasses='character',
                                   na.strings=""))
words <- as.character(words[1,])

sorted_words <- vapply(words, function(word) {
    paste(sort(strsplit(word, NULL)[[1]]), collapse='')
}, '')
anagrams <- names(which(table(sorted_words) > 1))

n <- 0
n2 <- 0
len_n2 <- 1
limit <- max(nchar(anagrams))
all_squares <- vector('list', limit + 1)
while ( len_n2 <= limit ) {
    n <- n + 1
    n2 <- n * n
    len_n2 <- nchar(as.character(n2))
    all_squares[[len_n2]] <- c(all_squares[[len_n2]], n2)
}

max_square <- 0
for ( anagram in anagrams ) {
    anagram_set <- names(sorted_words[sorted_words == anagram])
    pairs <- combn(anagram_set, 2, simplify=FALSE)
    for ( i in seq.int(length(pairs)) ) {
        pair <- pairs[[i]]
        squares <- all_squares[[nchar(pair[1])]]
        for ( square in squares ) {
            anagram1 <- strsplit(pair[1], NULL)[[1]]
            digits1 <- strsplit(as.character(square), NULL)[[1]]
            translation <- unique(cbind(anagram1, digits1))
            if ( length(translation[,1]) != length(unique(translation[,1])) ) {
                next
            }
            if ( length(translation[,1]) != length(unique(translation[,2])) ) {
                next
            }
            anagram2 <- strsplit(pair[2], NULL)[[1]]
            digits2 <- vector()
            for ( letter in anagram2 ) {
                digit <- translation[translation[,1] == letter][2]
                digits2 <- c(digits2, digit)
            }
            digits2 <- as.integer(paste(digits2, collapse=''))
            if ( sum(squares == digits2) ) {
                if ( square > max_square ) {
                    max_square <- square
                }
                if ( digits2 > max_square ) {
                    max_square <- digits2
                }
            }
        }
    }
}

cat(max_square, fill=TRUE)
