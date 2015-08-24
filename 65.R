# Convergents of e

suppressPackageStartupMessages(library(gmp))

options(scipen=100)

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 100, as.numeric(Args[6]))

a <- as.bigz(2)
for ( n in seq.int(ceiling((limit - 1) / 3)) ) {
    a <- c(a, 1, 2 * n, 1)
}

numer <- as.bigz(c(2, 3))
for ( n in seq.int(3, limit) ) {
    numer <- c(numer, a[n] * numer[length(numer)] + numer[length(numer) - 1])
}

cat(sum(as.integer(strsplit(as.character(numer[length(numer)]),
                            split=NULL)[[1]])), fill=TRUE)
