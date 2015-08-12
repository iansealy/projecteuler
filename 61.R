# Cyclical figurate numbers

Args     <- commandArgs()
set_size <- ifelse(is.na(Args[6]), 6, as.numeric(Args[6]))

get_cycle <- function(cycle, prefix_of, polygonal_type, set_size) {
    set_sum <- NA

    if ( length(cycle) == set_size ) {
        first_prefix <- substr(as.character(cycle[1]), 1, 2)
        last_suffix <- substr(as.character(cycle[set_size]), 3, 4)
        if ( first_prefix != last_suffix ) {
            return(NA)
        }
        if ( all_represented(cycle, polygonal_type, set_size) ) {
            return(sum(as.integer(cycle)))
        } else {
            return(NA)
        }
    }

    suffix <- substr(as.character(cycle[length(cycle)]), 3, 4)
    for ( next_num in prefix_of[[suffix]] ) {
        if ( next_num %in% cycle ) {
            next
        }
        set_sum <- get_cycle(c(cycle, next_num), prefix_of, polygonal_type,
                             set_size)
        if ( !is.na(set_sum) ) {
            break
        }
    }

    return(set_sum)
}

all_represented <- function(cycle, polygonal_type, set_size) {
    paths <- list()
    paths[[1]] <- vector()

    for ( num in cycle ) {
        types <- polygonal_type[[num]]
        if ( !length(types) ) {
            return(FALSE)
        }
        new_paths <- list()
        for ( type in types ) {
            for ( path in paths ) {
                new_paths[[length(new_paths)+1]] <- c(path, type)
            }
        }
        paths <- new_paths
    }

    for ( path in paths ) {
        if ( length(unique(path)) == set_size ) {
            return(TRUE)
        }
    }

    return(FALSE)
}

functions <- list(
    function(n) {n * (n + 1) / 2},
    function(n) {n * n},
    function(n) {n * (3 * n - 1) / 2},
    function(n) {n * (2 * n - 1)},
    function(n) {n * (5 * n - 3) / 2},
    function(n) {n * (3 * n - 2)}
)

polygonal <- vector()
polygonal_type <- list()
prefix_of <- list()
for ( type in seq.int(set_size) ) {
    n <- 1
    p <- 1
    while ( as.integer(p) < 10000 ) {
        p <- functions[[type]](n)
        if ( p >= 1000 && p < 10000 ) {
            polygonal <- c(polygonal, p)
            p <- as.character(p)
            polygonal_type[[p]] <- unique(c(polygonal_type[[p]], type))
            prefix <- substr(p, 1, 2)
            prefix_of[[prefix]] <- unique(c(prefix_of[[prefix]], p))
        }
        n <- n + 1
    }
}

set_sum <- NA

for ( num in unique(polygonal) ) {
    set_sum <- get_cycle(num, prefix_of, polygonal_type, set_size)
    if ( !is.na(set_sum) ) {
        break
    }
}

cat(set_sum, fill=TRUE)
