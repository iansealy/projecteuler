# Special subset sums: testing

library(gtools)

# Constants
SETS_URL <- 'https://projecteuler.net/project/resources/p105_sets.txt'

is_special_sum_set <- function(set) {
    n <- length(set)

    # Make indices for subsets
    subset_idxs <- permutations(2, n, repeats.allowed=TRUE) - 1
    mode(subset_idxs) <- 'logical'
    subset_idxs <- subset_idxs[2:(nrow(subset_idxs) - 1),]

    subsets <- apply(subset_idxs, 1, function(x) { set[x] })
    sums <- sapply(subsets, sum)
    lengths <- sapply(subsets, length)

    # Check for disjoint subsets with equal sums
    for ( subset_sum in unique(sums) ) {
        indices <- which(sums == subset_sum)
        if ( length(indices) == 1 ) {
            next
        }
        pairs <- combinations(length(indices), 2, indices)
        for ( j in seq.int(nrow(pairs)) ) {
            pair <- pairs[j,]
            if ( !length(intersect(subsets[pair[1]], subsets[pair[2]])) ) {
                return(FALSE)
            }
        }
    }

    # Check for disjoint subsets of different lengths and sums
    df <- expand.grid(sub1=seq.int(length(subsets)),
                      sub2=seq.int(length(subsets)))
    df$sum1 <- sums[df$sub1]
    df$sum2 <- sums[df$sub2]
    df$len1 <- lengths[df$sub1]
    df$len2 <- lengths[df$sub2]
    df <- df[df$len1 < df$len2,]
    df <- df[df$sum1 > df$sum2,]
    if ( !nrow(df) ) {
        return(TRUE)
    }

    for ( i in seq.int(nrow(df)) ) {
        pair <- as.integer(df[i, 1:2])
        if ( !length(intersect(subsets[pair[1]], subsets[pair[2]])) ) {
            return(FALSE)
        }
    }

    return(TRUE)
}

sets <- read.csv(sub('https', 'http', SETS_URL), header=FALSE,
                 col.names=as.character(seq.int(12)))

total <- 0
for ( i in seq.int(nrow(sets)) ) {
    set <- na.omit(as.integer(sets[i,]))
    if ( is_special_sum_set(set) ) {
        total <- total + sum(set)
    }
}

cat(total, fill=TRUE)
