# Coded triangle numbers

# Constants
WORDS_URL <- 'https://projecteuler.net/project/resources/p042_words.txt'

words <- suppressWarnings(read.csv(sub('https', 'http', WORDS_URL),
                                   header=FALSE, colClasses='character',
                                   na.strings=""))
words <- sort(as.character(words[1,]))

triangles <- sapply(seq.int(50), function(i) {
    return(i * (i + 1) / 2)
})

count <- sum(sapply(seq.int(length(words)), function(i) {
    value <- sum(as.numeric(charToRaw(words[i])) - 64)
    return(value %in% triangles)
}))

cat(count, fill=TRUE)
