# Disc game prize fund

Args  <- commandArgs()
turns <- ifelse(is.na(Args[6]), 15, as.numeric(Args[6]))

outcomes <- vector()
prev_outcomes <- c(1, 1)
turn <- 1
while ( turn < turns ) {
    turn <- turn + 1
    outcomes <- rep(0, turn + 1)
    for ( blue in seq.int(turn) ) {
        outcomes[blue] <- outcomes[blue] + prev_outcomes[blue]
    }
    for ( red in seq.int(2, turn + 1) ) {
        outcomes[red] <- outcomes[red] + prev_outcomes[red - 1] * turn
    }
    prev_outcomes <- outcomes
}

total <- sum(outcomes)
num_win <- (turns + 1) %/% 2
win <- sum(outcomes[1:num_win])

cat(total %/% win, fill=TRUE)
