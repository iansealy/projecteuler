# Special subset sums: optimum

library(gtools)

Args     <- commandArgs()
set_size <- ifelse(is.na(Args[6]), 7, as.integer(Args[6]))

algorithm_set <- function(prev_set) {
    middle <- prev_set[length(prev_set) / 2 + 1]
    set <- c(middle)
    for ( int in prev_set ) {
        set <- c(set, middle + int)
    }

    return(set)
}

optimum_set <- function(algo_set) {
    n <- length(algo_set)
    opt_sum <- sum(algo_set)
    opt_set <- algo_set

    # Make indices for subsets
    subset_idxs <- permutations(2, n, repeats.allowed=TRUE) - 1
    mode(subset_idxs) <- 'logical'
    subset_idxs <- subset_idxs[2:(nrow(subset_idxs) - 1),]

    # Check nearby sets
    offsets <- permutations(5, n, repeats.allowed=TRUE) - 3
    sets <- algo_set + offsets
    sets <- sets[rowSums(sets) < opt_sum, , drop=FALSE]
    sets <- sets[!rowSums(sets <= 0), , drop=FALSE] # Ensure positive integers
    sets <- sets[apply(sets, 1, function(x) { # Ensure unique integers
        length(unique(x)) == n
    }), , drop=FALSE]
    if ( !nrow(sets) ) {
        return(opt_set)
    }
    for ( i in seq.int(nrow(sets)) ) {
        set <- sets[i,]
        subsets <- apply(subset_idxs, 1, function(x) { set[x] })
        sums <- sapply(subsets, sum)
        lengths <- sapply(subsets, length)

        # Check for disjoint subsets with equal sums
        got_disjoint_eq_sum <- FALSE
        for ( subset_sum in unique(sums) ) {
            indices <- which(sums == subset_sum)
            if ( length(indices) == 1 ) {
                next
            }
            pairs <- combinations(length(indices), 2, indices)
            for ( j in seq.int(nrow(pairs)) ) {
                pair <- pairs[j,]
                if ( !length(intersect(subsets[pair[1]], subsets[pair[2]])) ) {
                    got_disjoint_eq_sum <- TRUE
                    break
                }
            }
        }
        if ( got_disjoint_eq_sum ) {
            next
        }

        # Check for disjoint subsets of different lengths and sums
        got_disjoint_diff <- FALSE
        pairs <- combinations(length(subsets), 2)
        for ( j in seq.int(nrow(pairs)) ) {
            pair <- pairs[j,]
            if ( lengths[pair[1]] == lengths[pair[2]] ) {
                next
            }
            if ( sums[pair[1]] == sums[pair[2]] ) {
                next
            }
            if ( length(intersect(subsets[pair[1]], subsets[pair[2]])) ) {
                next
            }
            if ( lengths[pair[1]] > lengths[pair[2]] &&
                sums[pair[1]] < sums[pair[2]] ) {
                got_disjoint_diff <- TRUE
                break
            }
            if ( lengths[pair[2]] > lengths[pair[1]] &&
                sums[pair[2]] < sums[pair[1]] ) {
                got_disjoint_diff <- TRUE
                break
            }
        }
        if ( got_disjoint_diff ) {
            next
        }

        opt_sum <- sum(set)
        opt_set <- set
    }

    return(sort(opt_set))
}

set <- c(1)
for ( n in seq.int(2, set_size) ) {
    set <- algorithm_set(set)
    set <- optimum_set(set)
}

cat(paste(set, collapse=''), fill=TRUE)
