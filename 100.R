# Arranged probability

# Constants
LIMIT <- 1e12

blue <- 85
num <- blue + 35
while ( num <= LIMIT ) {
    next_blue <- 3 * blue + 2 * num -2
    next_num <- 4 * blue + 3 * num -3
    blue <- next_blue
    num <- next_num
}

cat(blue, fill=TRUE)
