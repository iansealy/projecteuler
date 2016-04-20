# Su Doku

# Constants
SUDOKU_URL <- 'https://projecteuler.net/project/resources/p096_sudoku.txt'

solve <- function(sudoku) {
    prev_sum = sum(sudoku)
    while ( TRUE ) {
        sudoku <- check_candidates(sudoku)
        sudoku <- find_places(sudoku)
        new_sum <- sum(sudoku)
        if ( prev_sum == new_sum ) {
            break
        }
        prev_sum <- new_sum
    }

    sudoku <- brute_force(sudoku)

    return(sudoku)
}

check_candidates <- function(sudoku) {
    for ( i in seq.int(9) ) {
        for ( j in seq.int(9) ) {
            if ( sudoku[i, j] ) {
                next
            }
            possibles <- get_possible(c(i, j), sudoku)
            if ( length(possibles) == 1 ) {
                sudoku[i, j] <- possibles[1]
            }
        }
    }

    return(sudoku)
}

find_places <- function(sudoku) {
    cells <- list()

    # Columns
    for ( j in seq.int(9) ) {
        cells <- c(cells, list(get_col(c(1, j))))
    }
    # Rows
    for ( i in seq.int(9) ) {
        cells <- c(cells, list(get_row(c(i, 1))))
    }
    # Boxes
    for ( i in c(1, 4, 7) ) {
        for ( j in c(1, 4, 7) ) {
            cells <- c(cells, list(get_box(c(i, j))))
        }
    }

    for ( cell_set in cells ) {
        place <- matrix(, nrow=0, ncol=3)
        for ( cell in cell_set ) {
            if ( sudoku[cell[1], cell[2]] ) {
                next
            }
            for ( possible in get_possible(cell, sudoku) ) {
                place <- rbind(place, c(possible, cell))
            }
        }
        place <- unique(place)
        for ( possible in unique(place[,1]) ) {
            possible_cells <- place[place[,1] == possible, 2:3, drop=FALSE]
            if ( nrow(possible_cells) == 1 ) {
                sudoku[possible_cells[1,1], possible_cells[1,2]] <- possible
            }
        }
    }

    return(sudoku)
}

brute_force <- function(sudoku) {
    for ( i in seq.int(9) ) {
        for ( j in seq.int(9) ) {
            if ( sudoku[i, j] ) {
                next
            }
            possibles <- get_possible(c(i, j), sudoku)
            for ( possible in possibles ) {
                candidate_sudoku <- sudoku
                candidate_sudoku[i, j] <- possible
                candidate_sudoku <- brute_force(candidate_sudoku)
                if ( length(candidate_sudoku) > 1 ) {
                    return(candidate_sudoku)
                }
            }
            return()
        }
    }

    return(sudoku)
}

get_possible <- function(cell, sudoku) {
    possible <- rep(TRUE, 9)
    adjacent_cells <- list()
    adjacent_cells <- c(adjacent_cells, list(get_row(cell)))
    adjacent_cells <- c(adjacent_cells, list(get_col(cell)))
    adjacent_cells <- c(adjacent_cells, list(get_box(cell)))
    for ( i in 1:3 ) {
        for ( adj_cell in adjacent_cells[[i]] ) {
            if ( sudoku[adj_cell[1], adj_cell[2]] ) {
                possible[sudoku[adj_cell[1], adj_cell[2]]] <- FALSE
            }
        }
    }

    return(which(possible))
}

get_row <- function(cell) {
    cells <- list()
    for ( i in seq.int(9) ) {
        cells <- c(cells, list(c(cell[1], i)))
    }

    return(cells)
}

get_col <- function(cell) {
    cells <- list()
    for ( i in seq.int(9) ) {
        cells <- c(cells, list(c(i, cell[2])))
    }

    return(cells)
}

get_box <- function(cell) {
    cells <- list()
    box_topleft <- (cell - 1) %/% 3 * 3 + 1
    for ( i in seq.int(0, 2) ) {
        for ( j in seq.int(0, 2) ) {
            cells <- c(cells, list(c(box_topleft[1] + i, box_topleft[2] + j)))
        }
    }

    return(cells)
}

sudokus <- suppressWarnings(read.delim(sub('https', 'http', SUDOKU_URL),
                                       header=FALSE,
                                       colClasses='character'))[,1]

total <- 0

for ( i in seq.int(0, 49) ) {
    start <- i * 10 + 2
    rows <- sudokus[start:(start + 8)]
    sudoku <- matrix(as.integer(unlist(strsplit(rows, split=NULL))), ncol=9,
                     byrow=TRUE)
    sudoku <- solve(sudoku)
    total <- total + as.integer(paste(sudoku[1, 1:3], collapse=''))
}

cat(total, fill=TRUE)
