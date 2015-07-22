#!/usr/bin/env python

"""This script solves the Project Euler problem "Lychrel numbers". The problem
is: How many Lychrel numbers are there below ten-thousand?
"""


def main():
    """Lychrel numbers"""

    # Constants
    LIMIT = 10000

    count = 0
    for num in range(1, LIMIT):
        digits = [int(i) for i in str(num)]
        is_lychrel = True
        for _ in range(50):
            digits = add_reverse(digits)
            if is_palindrome(digits):
                is_lychrel = False
                break
        if is_lychrel:
            count += 1

    print(count)


def add_reverse(digits):
    """Add number to its reverse"""

    reverse_digits = digits[::-1]
    new_digits = []
    carry = 0
    while digits:
        digit_sum = digits.pop() + reverse_digits.pop() + carry
        new_digits.append(int(str(digit_sum)[-1]))
        if digit_sum >= 10:
            carry = int(str(digit_sum)[:-1])
        else:
            carry = 0
    if carry:
        new_digits.extend([int(i) for i in reversed(str(carry))])

    return(new_digits)


def is_palindrome(digits):
    """Check if number is palindrome"""

    number = ''.join(str(digits))
    rev_number = ''.join(str(digits[::-1]))

    return(number == rev_number)

if __name__ == '__main__':
    main()
