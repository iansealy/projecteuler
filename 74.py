#!/usr/bin/env python

"""This script solves the Project Euler problem "Digit factorial chains". The
problem is: How many chains, with a starting number below one million, contain
exactly sixty non-repeating terms?
"""


def main():
    """Digit factorial chains"""

    # Constants
    LIMIT = 1000000
    TARGET = 60

    factorials = get_factorials_up_to(9)

    chain_length_for = {}
    target_count = 0
    for num in range(LIMIT):
        # Check cache
        sorted_digits = ''.join(sorted(str(num)))
        if sorted_digits in chain_length_for:
            if chain_length_for[sorted_digits] == TARGET:
                target_count += 1
            continue

        chain_length = 1
        chain_num = num
        seen = {num: True}
        while True:
            chain_num = sum(factorials[int(digit)] for digit in str(chain_num))
            if chain_num in seen:
                break
            seen[chain_num] = True
            chain_length += 1

        # Cache
        chain_length_for[num] = chain_length
        if chain_length == TARGET:
            target_count += 1

    print(target_count)


def get_factorials_up_to(limit):
    factorials = [1]
    factorial = 1
    for num in range(1, limit + 1):
        factorial *= num
        factorials.append(factorial)

    return factorials

if __name__ == '__main__':
    main()
