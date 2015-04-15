# Counting Sundays

# Constants
START_YEAR       <- 1900
END_YEAR         <- 2000
COUNT_START_YEAR <- 1901

get_days_in_month <- function(year, is_last) {
    feb_days <- 28
    if ( year %% 4 == 0 && ( year %% 100 != 0 || year %% 400 == 0 ) ) {
        feb_days <- 29
    }

    #          Jan           Mar Apr May Jun Jul Aug Sep Oct Nov Dec
    days <- c( 31, feb_days, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 );

    if ( is_last ) {
        days <- days[1:11]
    }

    return(days)
}

day_of_week <- 1 # Monday 1st Jan 1900

sunday_count <- 0

for ( year in START_YEAR:END_YEAR ) {
    for ( days in get_days_in_month(year, year == END_YEAR) ) {
        day_of_week <- ( day_of_week + days ) %% 7
        if ( day_of_week == 0 && year >= COUNT_START_YEAR ) {
            sunday_count <- sunday_count + 1
        }
    }
}

cat(sunday_count, fill=TRUE)
