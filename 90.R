# Cube digit pairs

# Constants
SQUARES <- c('01', '04', '09', '16', '25', '36', '49', '64', '81')

all_squares <- function(comb1, comb2) {
    products <- vector()
    for ( i in seq.int(length(comb1)) ) {
        for ( j in seq.int(length(comb2)) ) {
            products <- c(products, paste(c(comb1[i], comb2[j]), collapse=''))
            products <- c(products, paste(c(comb2[j], comb1[i]), collapse=''))
        }
    }
    if ( length(intersect(SQUARES, unique(products))) == length(SQUARES) ) {
        return(TRUE)
    } else {
        return(FALSE)
    }
}

distinct <- 0
combs <- combn(0:9, 6, simplify=FALSE)
for ( i in seq.int(length(combs)) ) {
    if ( 6 %in% combs[[i]] && !(9 %in% combs[[i]]) ) {
        combs[[i]] <- c(combs[[i]], 9)
    }
    if ( 9 %in% combs[[i]] && !(6 %in% combs[[i]]) ) {
        combs[[i]] <- c(combs[[i]], 6)
    }
}
for ( i in seq.int(length(combs)) ) {
    for ( j in seq.int(length(combs)) ) {
        if ( all_squares(combs[[i]], combs[[j]]) ) {
            distinct <- distinct + 1
        }
    }
}

cat(distinct / 2, fill=TRUE)
