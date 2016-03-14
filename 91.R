# Right triangles with integer coordinates

Args <- commandArgs()
max  <- ifelse(is.na(Args[6]), 50, as.integer(Args[6]))

ints <- seq.int(0, max)
df <- expand.grid(x1=ints, y1=ints, x2=ints, y2=ints)
df <- df[!(df$x1 == 0 & df$y1 == 0),]
df <- df[!(df$x2 == 0 & df$y2 == 0),]
df <- df[!(df$x1 == df$x2 & df$y1 == df$y2),]
df$x3 <- df$x2 - df$x1
df$y3 <- df$y2 - df$y1
df$p1 <- df$x1 * df$x2 + df$y1 * df$y2
df$p2 <- df$x2 * df$x3 + df$y2 * df$y3
df$p3 <- df$x3 * df$x1 + df$y3 * df$y1
df <- df[!df$p1 | !df$p2 | !df$p3,]

cat(nrow(df) / 2, fill=TRUE)
