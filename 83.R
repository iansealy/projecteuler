# Path sum: four ways

Args <- commandArgs()
url  <- ifelse(is.na(Args[6]),
               'https://projecteuler.net/project/resources/p083_matrix.txt',
               as.character(Args[6]))

matrix <- data.matrix(read.csv(url, header=FALSE, colClasses='character'))

# Label nodes
destination <- nrow(matrix) * ncol(matrix)
node_for <- matrix(seq.int(destination), nrow=nrow(matrix), ncol=ncol(matrix),
                   byrow=TRUE)

# Make graph
graph <- c(0, 0, 0)

# Up
for ( i in seq.int(2, nrow(matrix)) ) {
    for ( j in seq.int(ncol(matrix)) ) {
        graph <- rbind(graph, c(node_for[i,j], node_for[i-1,j], matrix[i-1,j]))
    }
}

# Down
for ( i in seq.int(nrow(matrix) - 1) ) {
    for ( j in seq.int(ncol(matrix)) ) {
        graph <- rbind(graph, c(node_for[i,j], node_for[i+1,j], matrix[i+1,j]))
    }
}

# Left
for ( i in seq.int(nrow(matrix)) ) {
    for ( j in seq.int(2, ncol(matrix)) ) {
        graph <- rbind(graph, c(node_for[i,j], node_for[i,j-1], matrix[i,j-1]))
    }
}

# Right
for ( i in seq.int(nrow(matrix)) ) {
    for ( j in seq.int(ncol(matrix) - 1) ) {
        graph <- rbind(graph, c(node_for[i,j], node_for[i,j+1], matrix[i,j+1]))
    }
}

graph <- graph[2:nrow(graph),]

# Dijkstra
node <- 1
unvisited <- rep(TRUE, destination)
distance <- rep(NA, destination)
distance[node] <- matrix[1,1]
while ( is.na(distance[destination]) ) {
    for ( next_node in graph[graph[,1] == node,2] ) {
        if ( is.na(distance[next_node]) ||
                distance[next_node] > distance[node] +
                graph[graph[,1] == node & graph[,2] == next_node,3] ) {
            distance[next_node] <- distance[node] +
                graph[graph[,1] == node & graph[,2] == next_node,3]
        }
    }
    unvisited[node] <- FALSE
    nodes <- which(!is.na(distance) & unvisited)
    node <- min(which(distance == min(distance[nodes]) & unvisited))
}

cat(distance[destination], fill=TRUE)
