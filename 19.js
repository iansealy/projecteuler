#!/usr/bin/env node

// Counting Sundays

var START_YEAR = 1900;
var END_YEAR = 2000;
var COUNT_START_YEAR = 1901;

var day_of_week = 1; // Monday 1st Jan 1900

var sunday_count = 0;

for (var year = START_YEAR; year <= END_YEAR; year++) {
    var days = get_days_in_month(year, year == END_YEAR);
    for (var i = 0; i < days.length; i++) {
        day_of_week = (day_of_week + days[i]) % 7;
        if (day_of_week == 0 && year >= COUNT_START_YEAR) {
            sunday_count++;
        }
    }
}

console.log(sunday_count);

function get_days_in_month(year, is_last) {
    var feb_days = 28;
    if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) {
        feb_days = 29;
    }

    //          Jan           Mar Apr May Jun Jul Aug Sep Oct Nov Dec
    var days = [31, feb_days, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    if (is_last) {
        days.pop();
    }

    return days;
}
