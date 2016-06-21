# Minimal network

# Constants
NETWORK_URL <- 'https://projecteuler.net/project/resources/p107_network.txt'

mat <- read.csv(sub('https', 'http', NETWORK_URL), header=FALSE,
                colClasses="integer", na.strings="-")

num_vertices <- nrow(mat)
node1 <- vector()
node2 <- vector()
weight <- vector()
for ( i in seq.int(num_vertices - 1) ) {
    for ( j in seq.int(i + 1, num_vertices) ) {
        if ( !is.na(mat[i, j]) ) {
            node1 <- c(node1, i)
            node2 <- c(node2, j)
            weight <- c(weight, mat[i, j])
        }
    }
}
edges <- data.frame(node1, node2, weight)
edges <- edges[order(edges$weight),]
total_weight <- sum(weight)

graph <- data.frame(node1=integer(), node2=integer())
minimum_weight <- 0
for ( i in seq.int(nrow(edges)) ) {
    node1 <- edges[i, 1]
    node2 <- edges[i, 2]
    weight <- edges[i, 3]

    undiscovered <- seq.int(num_vertices)
    s <- c(node1)
    while ( length(s) ) {
        v <- s[1]
        s <- s[-1]
        if ( v %in% undiscovered ) {
            undiscovered <- undiscovered[!(undiscovered == v)]
            s <- c(s, graph$node2[graph$node1 == v])
        }
    }
    if ( node2 %in% undiscovered ) {
        graph <- rbind(graph, data.frame(node1=node1, node2=node2))
        graph <- rbind(graph, data.frame(node1=node2, node2=node1))
        minimum_weight <- minimum_weight + weight
    }
}

cat(total_weight - minimum_weight, fill=TRUE)
