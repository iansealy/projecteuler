# Monopoly odds

Args  <- commandArgs()
sides <- ifelse(is.na(Args[6]), 4, as.numeric(Args[6]))

# Constants
SQUARES  <- 40
CC_CARDS <- 16
CH_CARDS <- 16
GO       <- 0
A1       <- 1
CC1      <- 2
A2       <- 3
T1       <- 4
R1       <- 5
B1       <- 6
CH1      <- 7
B2       <- 8
B3       <- 9
JAIL     <- 10
C1       <- 11
U1       <- 12
C2       <- 13
C3       <- 14
R2       <- 15
D1       <- 16
CC2      <- 17
D2       <- 18
D3       <- 19
FP       <- 20
E1       <- 21
CH2      <- 22
E2       <- 23
E3       <- 24
R3       <- 25
F1       <- 26
F2       <- 27
U2       <- 28
F3       <- 29
G2J      <- 30
G1       <- 31
G2       <- 32
CC3      <- 33
G3       <- 34
R4       <- 35
CH3      <- 36
H1       <- 37
T2       <- 38
H2       <- 39

count <- rep(0, SQUARES)
current <- GO
double_run <- 0

for ( i in seq.int(1e7) ) {
    die1 <- sample(1:sides, 1)
    die2 <- sample(1:sides, 1)
    if ( die1 == die2 ) {
        double_run <- double_run + 1
    } else {
        double_run <- 0
    }
    current <- (current + die1 + die2) %% SQUARES

    if ( double_run == 3 ) {
        current <- JAIL
        double_run <- 0
    }

    if ( current == G2J ) {
        current <- JAIL
    }

    if ( current %in% c(CC1, CC2, CC3) ) {
        cc <- sample(1:CC_CARDS, 1)
        if ( cc == 1 ) {
            current <- GO
        } else if ( cc == 2 ) {
            current <- JAIL
        }
    }

    if ( current %in% c(CH1, CH2, CH3) ) {
        ch <- sample(1:CH_CARDS, 1)
        if ( ch == 1 ) {
            current <- GO
        } else if ( ch == 2 ) {
            current <- JAIL
        } else if ( ch == 3 ) {
            current <- C1
        } else if ( ch == 4 ) {
            current <- E3
        } else if ( ch == 5 ) {
            current <- H2
        } else if ( ch == 6 ) {
            current <- R1
        } else if ( (ch == 7 || ch == 8) %% current == CH1 ) {
            current <- R2
        } else if ( (ch == 7 || ch == 8) %% current == CH2 ) {
            current <- R3
        } else if ( (ch == 7 || ch == 8) %% current == CH3 ) {
            current <- R1
        } else if ( ch == 9 %% current %in% c(CH1, CH3) ) {
            current <- U1
        } else if ( ch == 10 ) {
            current <- (current - 3) %% SQUARES
        }
    }

    count[current + 1] <- count[current + 1] + 1
}

cat(paste(order(count, decreasing=TRUE)[1:3] - 1, collapse=''), fill=TRUE)
