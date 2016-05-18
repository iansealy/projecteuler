# Triangle containment

# Constants
TRI_URL <- 'https://projecteuler.net/project/resources/p102_triangles.txt'

tri <- read.csv(sub('https', 'http', TRI_URL), header=FALSE,
                col.names=c("x1", "y1", "x2", "y2", "x3", "y3"))
tri$area <- with(tri, abs(x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2) / 2))
tri$area1 <- with(tri, abs(0 * (y2 - y3) + x2 * (y3 - 0) + x3 * (0 - y2) / 2))
tri$area2 <- with(tri, abs(x1 * (0 - y3) + 0 * (y3 - y1) + x3 * (y1 - 0) / 2))
tri$area3 <- with(tri, abs(x1 * (y2 - 0) + x2 * (0 - y1) + 0 * (y1 - y2) / 2))

cat(sum(with(tri, area1 + area2 + area3 == area)), fill=TRUE)
