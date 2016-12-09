# Singleton difference

library(parallel)

Args  <- commandArgs()
limit <- ifelse(is.na(Args[6]), 50000000, as.numeric(Args[6]))

cl <- makeCluster(detectCores() - 1)
clusterExport(cl, "limit")

# x = y + d
# z = y - d
# x^2 - y^2 - z^2 = n
# (y + d)^2 -y^2 - (y - d)^2 = n
# 4dy - y^2 = n
# y(4d - y) = n

get_n <- function(y) {
    d <- seq.int(as.integer(y / 4 + 1), limit)
    d <- d[1:(sum(y - d > 0))]
    n <- y * (4 * d - y)
    n <- n[n < limit]
    return(n)
}

ns <- unlist(parLapply(cl, seq.int(2, limit), get_n))

stopCluster(cl)

cat(sum(table(ns) == 1), fill=TRUE)
