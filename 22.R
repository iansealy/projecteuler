# Names scores

# Constants
NAMES_URL <- 'https://projecteuler.net/project/resources/p022_names.txt'

names <- suppressWarnings(read.csv(sub('https', 'http', NAMES_URL),
                                   header=FALSE, colClasses='character',
                                   na.strings=""))
names <- sort(as.character(names[1,]))

total <- sum(sapply(seq.int(length(names)), function(i) {
    return(i * sum(as.numeric(charToRaw(names[i])) - 64))
}))

cat(total, fill=TRUE)
