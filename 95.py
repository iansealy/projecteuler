#!/usr/bin/env python

"""This script solves the Project Euler problem "Amicable chains". The problem
is: Find the smallest member of the longest amicable chain with no element
exceeding one million.
"""


def main():
    """Amicable chains"""

    # Constants
    MAX = 1000000

    is_chain = {
        '0': False
    }

    sum_proper_divisors_for = {}

    for num in range(1, MAX):
        sum = sum_proper_divisors(num)
        sum_proper_divisors_for[num] = sum
        if sum >= MAX:
            sum_proper_divisors_for[num] = None
            is_chain[num] = False

    max_chain_length = 0
    max_chain_min_num = 0
    for num in range(1, MAX):
        if num in is_chain and not is_chain[num]:
            continue
        got_chain = True
        chain = [num]
        seen = {num: True}
        while True:
            if chain[-1] not in sum_proper_divisors_for:
                got_chain = False
                break
            chain.append(sum_proper_divisors_for[chain[-1]])
            if chain[0] == chain[-1]:
                break
            if chain[-1] in seen:
                got_chain = False
                break
            seen[chain[-1]] = True
            if chain[-1] in is_chain and is_chain[chain[-1]]:
                got_chain = False
                break
        if got_chain:
            is_chain[num] = True
            if len(chain) - 1 > max_chain_length:
                max_chain_length = len(chain) - 1
                max_chain_min_num = num

    print(max_chain_min_num)


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
