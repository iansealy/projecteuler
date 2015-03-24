#!/usr/bin/env python

"""This script solves the Project Euler problem "Counting Sundays". The problem
is: How many Sundays fell on the first of the month during the twentieth
century (1 Jan 1901 to 31 Dec 2000)?
"""


def main():
    """Counting Sundays"""

    # Constants
    START_YEAR = 1900
    END_YEAR = 2000
    COUNT_START_YEAR = 1901

    day_of_week = 1  # Monday 1st Jan 1900

    sunday_count = 0

    for year in range(START_YEAR, END_YEAR + 1):
        for days in get_days_in_month(year, year == END_YEAR):
            day_of_week = (day_of_week + days) % 7
            if day_of_week == 0 and year >= COUNT_START_YEAR:
                sunday_count += 1

    print(sunday_count)


def get_days_in_month(year, is_last):
    """Get number of days in each month for a particular year"""

    feb_days = 28
    if year % 4 == 0 and (year % 100 != 0 or year % 400 == 0):
        feb_days = 29

    #       Jan           Mar Apr May Jun Jul Aug Sep Oct Nov Dec
    days = [31, feb_days, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    if is_last:
        days.pop()

    return days

if __name__ == '__main__':
    main()
