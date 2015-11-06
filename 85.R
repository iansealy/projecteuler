# Counting rectangles

# Constants
TARGET <- 2000000

rect <- expand.grid(1:2000, 1:2000)
colnames(rect) <- c('length', 'width')
rect$lengthTriangle <- rect$length * (rect$length + 1) / 2
rect$widthTriangle <- rect$width * (rect$width + 1) / 2
rect$diff <- abs(rect$lengthTriangle * rect$widthTriangle - TARGET)

closest_diff <- min(rect$diff)
closest_area <- rect$length[rect$diff == closest_diff] *
    rect$width[rect$diff == closest_diff]

cat(closest_area[1], fill=TRUE)
