#!/usr/bin/env python

"""This script solves the Project Euler problem "Powerful digit sum". The
problem is: Considering natural numbers of the form, a^b, where a, b < 100,
what is the maximum digital sum?
"""


def main():
    """Powerful digit sum"""

    # Constants
    LIMIT = 100

    max_digit_sum = 0
    for a in range(2, LIMIT):
        digits = [int(i) for i in str(a)[::-1]]
        for _ in range(2, LIMIT):
            new_digits = []
            carry = 0
            for digit in digits:
                digit_product = digit * a + carry
                new_digits.append(int(str(digit_product)[-1]))
                if digit_product >= 10:
                    carry = int(str(digit_product)[:-1])
                else:
                    carry = 0
            if carry:
                new_digits.extend([int(i) for i in reversed(str(carry))])
            digits = new_digits
            digit_sum = sum(digits)
            if digit_sum > max_digit_sum:
                max_digit_sum = digit_sum

    print(max_digit_sum)

if __name__ == '__main__':
    main()
