# Poker hands

# Constants
HANDS_URL <- 'https://projecteuler.net/project/resources/p054_poker.txt'

score <- function(hand) {
    trans_from <- c('T', 'J', 'Q', 'K', 'A')
    trans_to <- c('A', 'B', 'C', 'D', 'E')
    ranks <- vector()
    suits <- vector()
    for ( card in hand ) {
        rank <- substring(card, 1, 1)
        suit <- substring(card, 2)
        if ( rank %in% trans_from ) {
            rank <- trans_to[trans_from == rank]
        }
        ranks <- c(ranks, rank)
        suits <- c(suits, suit)
    }
    ranks <- sort(ranks)
    rank_count <- table(ranks)
    suit_count <- table(suits)

    flush <- FALSE
    if ( length(suit_count) == 1 ) {
        flush <- TRUE
    }

    straight <- FALSE
    low <- as.integer(as.hexmode(ranks[1]))
    high <- as.integer(as.hexmode(ranks[5]))
    if ( length(rank_count) == 5 && high - low == 4 ) {
        straight <- TRUE
    }

    score <- NA
    if ( flush && straight ) {
        score <- 9 # Straight flush
    } else if ( 4 %in% rank_count ) {
        score <- 8 # Four of a kind
    } else if ( length(rank_count) == 2 ) {
        score <- 7 # Full house
    } else if ( flush ) {
        score <- 6 # Flush
    } else if ( straight ) {
        score <- 5 # Straight
    } else if ( 3 %in% rank_count ) {
        score <- 4 # Three of a kind
    } else if ( length(rank_count) == 3 ) {
        score <- 3 # Two pair
    } else if ( length(rank_count) == 4 ) {
        score <- 2 # One pair
    } else {
        score <- 1 # High card
    }

    score <- as.character(score)

    for ( rank in rev(names(sort(rank_count))) ) {
        for ( i in seq.int(rank_count[rank]) ) {
            score <- c(score, rank)
        }
    }

    score <- paste(score, collapse='')

    return(score)
}

player1_wins <- 0

hands <- suppressWarnings(read.delim(sub('https', 'http', HANDS_URL),
                                     header=FALSE, sep=' ',
                                     colClasses='character'))
for ( i in 1:nrow(hands) ) {
    hand1 <- hands[i,1:5]
    hand2 <- hands[i,6:10]
    if ( score(hand1) > score(hand2) ) {
        player1_wins <- player1_wins + 1
    }
}

cat(player1_wins, fill=TRUE)
