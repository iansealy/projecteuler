# Magic 5-gon ring

library(gtools)

Args          <- commandArgs()
ring_size     <- ifelse(is.na(Args[6]),  5, as.numeric(Args[6]))
max_digit     <- ifelse(is.na(Args[7]), 10, as.numeric(Args[7]))
target_digits <- ifelse(is.na(Args[8]), 16, as.numeric(Args[8]))

# Group combinations by total
all_combs <- combn(seq.int(max_digit), 3)
totals <- colSums(all_combs)
required_totals <- as.integer(names(table(totals))[table(totals) >= ring_size])
total_combs <- list()
for ( total in required_totals ) {
    total_combs[[as.character(total)]] <- all_combs[,totals %in% total]
}

# Group combinations into rings with correct digits
combs <- list()
for ( comb in total_combs ) {
    comb_idxs <- combn(seq.int(ncol(comb)), ring_size)
    for ( idxs in seq.int(ncol(comb_idxs)) ) {
        mat <- comb[,comb_idxs[,idxs]]
        tab <- table(mat)
        if ( length(tab) != max_digit || max(tab) != 2 ) {
            next
        }
        for ( col in seq.int(ncol(mat)) ) {
            for ( row in c(2, 3) ) {
                if ( tab[mat[row,col]] == 1 ) {
                    tmp <- mat[row,col]
                    mat[row,col] <- mat[1,col]
                    mat[1,col] <- tmp
                }
            }
        }
        combs <- c(combs, list(mat))
    }
}

# Make all combinations of last two digits of each group
new_combs <- list()
for ( comb in combs ) {
    group1 <- comb[,1]
    group2 <- comb[,1]
    group2[2] <- group1[3]
    group2[3] <- group1[2]
    digit_combs <- list(matrix(group1), matrix(group2))
    for ( i in seq.int(2, ring_size) ) {
        group1 <- comb[,i]
        group2 <- comb[,i]
        group2[2] <- group1[3]
        group2[3] <- group1[2]
        new_digit_combs <- list()
        for ( digit_perm in digit_combs ) {
            new_digit_comb1 <- cbind(digit_perm, group1)
            new_digit_comb2 <- cbind(digit_perm, group2)
            new_digit_combs <- c(new_digit_combs, list(new_digit_comb1))
            new_digit_combs <- c(new_digit_combs, list(new_digit_comb2))
        }
        digit_combs <- new_digit_combs
    }
    new_combs <- c(new_combs, digit_combs)
}
combs <- new_combs

# Get all permutations of each combination and filter invalid ones
max_string <- '0'
for ( comb in combs ) {
    perm_idxs <- permutations(ring_size, ring_size)
    for ( row in seq.int(nrow(perm_idxs)) ) {
        ring <- comb[,perm_idxs[row,]]
        if ( ring[1,1] != min(ring[1,]) ) {
            next
        }
        string <- ''
        for ( i in seq.int(ring_size) ) {
            if ( ring[3,i] != ring[2,(i %% ring_size) + 1] ) {
                break
            }
            substring <- paste(ring[,i], sep='', collapse='')
            string <- paste(string, substring, sep='', collapse='')
        }
        if ( nchar(string) != target_digits ) {
            next
        }
        if ( string > max_string ) {
            max_string <- string
        }
    }
}

cat(max_string, sep="", fill=TRUE)
