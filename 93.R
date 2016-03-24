# Arithmetic expressions

library(gtools)

Args      <- commandArgs()
max_digit <- ifelse(is.na(Args[6]), 9, as.integer(Args[6]))

functions <- list(
    function(n1, n2) {n1 + n2},
    function(n1, n2) {n1 - n2},
    function(n1, n2) {n1 * n2},
    function(n1, n2) {n1 / n2}
)

op_perms <- permutations(4, 3, repeats.allowed=TRUE)
order_perms <- permutations(3, 3)

max_digits <- NA
max_consec <- 0

digit_combs <- combinations(max_digit, 4)
for ( i in seq.int(nrow(digit_combs)) ) {
    digit_comb <- digit_combs[i,]
    seen <- vector()
    digit_perms <- permutations(4, 4, v=digit_comb)
    for ( j in seq.int(nrow(digit_perms)) ) {
        for ( k in seq.int(nrow(op_perms)) ) {
            for ( l in seq.int(nrow(order_perms)) ) {
                nums <- digit_perms[j,]
                ops <- op_perms[k,]
                order <- order_perms[l,]
                while ( length(order) ) {
                    ordinal <- order[length(order)]
                    length(order) <- length(order) - 1
                    num1 <- nums[ordinal]
                    num2 <- nums[ordinal + 1]
                    nums <- nums[-ordinal]
                    op <- ops[ordinal]
                    ops <- ops[-ordinal]
                    nums[ordinal] <- functions[[op]](num1, num2)
                    if ( length(order) ) {
                        for ( o in seq.int(length(order)) ) {
                            if ( order[o] > ordinal ) {
                                order[o] <- order[o] - 1
                            }
                        }
                    }
                }
                num <- nums[1]
                if ( is.infinite(num) || as.integer(num) != num ||
                    num < 1 ) {
                    next
                }
                seen[num] <- TRUE
            }
        }
    }
    consec <- 0
    while ( !is.na(seen[consec + 1]) ) {
        consec <- consec + 1
    }
    if ( consec > max_consec ) {
        max_consec <- consec
        max_digits <- paste(sort(digit_comb), collapse='')
    }
}

cat(max_digits, fill=TRUE)
