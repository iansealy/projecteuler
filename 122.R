# Efficient exponentiation

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 200, as.numeric(Args[6]))

make_tree <- function(exponent, depth, tree, multis, limit) {
    if ( exponent > limit ) {
        return(multis)
    }
    if ( length(multis) >= exponent + 1 && depth > multis[exponent + 1] ) {
        return(multis)
    }

    multis[exponent + 1] <- depth
    tree[depth + 1] <- exponent

    for ( prev_depth in seq.int(depth, 0) ) {
        multis <- make_tree(exponent + tree[prev_depth + 1], depth + 1, tree,
                            multis, limit)
    }

    return(multis)
}

multis <- make_tree(1, 0, vector(), rep(Inf, limit + 1), limit)
multis[1] <- 0

cat(sum(multis), fill=TRUE)
