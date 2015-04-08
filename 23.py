#!/usr/bin/env python

"""This script solves the Project Euler problem Non-abundant sums". The problem
is: What is the total of all the name scores in the file?
"""


def main():
    """Non-abundant sums"""

    # Constants
    HIGHEST_ABUNDANT_SUM = 28123

    abundant_nums = [num for num in range(1, HIGHEST_ABUNDANT_SUM + 1)
                     if sum_proper_divisors(num) > num]

    abundant_sum = {i + j for i in abundant_nums for j in abundant_nums
                    if i + j <= HIGHEST_ABUNDANT_SUM}

    sum = 0
    for num in range(1, HIGHEST_ABUNDANT_SUM + 1):
        if num not in abundant_sum:
            sum += num

    print(sum)


def sum_proper_divisors(number):
    """Sum all proper divisors of a number"""

    return(sum_divisors(number) - number)


def sum_divisors(number):
    """Sum all divisors of a number"""

    sum = 1
    prime = 2

    while prime * prime <= number and number > 1:
        if number % prime == 0:
            j = prime * prime
            number //= prime
            while number % prime == 0:
                j *= prime
                number //= prime
            sum *= (j - 1)
            sum //= (prime - 1)
        if prime == 2:
            prime = 3
        else:
            prime += 2
    if number > 1:
        sum *= (number + 1)

    return(sum)

if __name__ == '__main__':
    main()
