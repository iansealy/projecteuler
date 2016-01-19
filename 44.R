# Pentagon numbers

limit <- 10
min_diff <- NA
while ( is.na(min_diff) ) {
    limit <- limit * 10
    num <- 1:limit
    pentagon <- num * (3 * num - 1) / 2
    df <- expand.grid(pentagon1=pentagon, pentagon2=pentagon)
    df <- df[df$pentagon1 > df$pentagon2,]
    df$sum <- df$pentagon1 + df$pentagon2
    df$diff <- df$pentagon1 - df$pentagon2
    df <- df[df$sum %in% pentagon,]
    df <- df[df$diff %in% pentagon,]
    if ( nrow(df) ) {
        min_diff <- min(df$diff)
    }
}

cat(min_diff, fill=TRUE)
