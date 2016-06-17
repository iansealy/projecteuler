# Special subset sums: meta-testing

library(gtools)

Args     <- commandArgs()
set_size <- ifelse(is.na(Args[6]), 12, as.integer(Args[6]))

max_subset <- set_size %/% 2

set <- seq.int(set_size)

subset_idxs <- permutations(2, set_size, repeats.allowed=TRUE) - 1
mode(subset_idxs) <- 'logical'
subset_idxs <- subset_idxs[2:(nrow(subset_idxs) - 1),]
subsets <- apply(subset_idxs, 1, function(x) { set[x] })
lengths <- sapply(subsets, length)
subsets <- lapply(subsets, function(x) { length(x) <- max_subset; return(x) })

df <- expand.grid(sub1=seq.int(length(subsets)),
                  sub2=seq.int(length(subsets)))
df <- df[df$sub2 > df$sub1,]
df$len1 <- lengths[df$sub1]
df$len2 <- lengths[df$sub2]
df <- df[df$len1 + df$len2 <= set_size,]
df <- df[df$len1 == df$len2,]
df <- df[df$len1 > 1,]

mat1 <- matrix(unlist(subsets[df$sub1]), ncol=max_subset, byrow=TRUE)
mat2 <- matrix(unlist(subsets[df$sub2]), ncol=max_subset, byrow=TRUE)
df$pos_sums <- rowSums(mat1 - mat2 > 0, na.rm=TRUE)
df$neg_sums <- rowSums(mat1 - mat2 < 0, na.rm=TRUE)
df <- df[df$pos_sums != df$len1 & df$neg_sums != df$len1,]
df <- df[df$pos_sums + df$neg_sums == df$len1,]

count <- 0
for ( i in seq.int(nrow(df)) ) {
    pair <- as.integer(df[i, 1:2])
    subset1 <- na.omit(subsets[[pair[1]]])
    subset2 <- na.omit(subsets[[pair[2]]])
    if ( length(intersect(subset1, subset2)) ) {
        next
    }
    count <- count + 1
}

cat(paste(count, collapse=''), fill=TRUE)
