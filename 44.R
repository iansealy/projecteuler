# Pentagon numbers

is_pentagonal <- new.env(hash=TRUE)
assign(as.character(1), TRUE, is_pentagonal)
pentagons <- 1
diff <- 0
n <- 1
while ( !diff ) {
    n <- n + 1
    next_pentagon <- n * (3 * n - 1) / 2
    candidates <- next_pentagon - pentagons
    candidate_diffs <- abs(pentagons - candidates)
    for ( i in seq.int(length(pentagons)) ) {
        if ( exists(as.character(candidates[i]), is_pentagonal) &&
            exists(as.character(candidate_diffs[i]), is_pentagonal) ) {
            diff <- candidate_diffs[i]
        }
    }
    pentagons <- c(next_pentagon, pentagons)
    assign(as.character(next_pentagon), TRUE, is_pentagonal)
}

cat(diff, fill=TRUE)
