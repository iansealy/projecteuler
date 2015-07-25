#!/usr/bin/env python

"""This script solves the Project Euler problem "Combinatoric selections". The
problem is: How many, not necessarily distinct, values of  nCr, for
1 <= n <= 100, are greater than one-million?
"""


def main():
    """Combinatoric selections"""

    # Constants
    N = 100

    fac_digits = get_factorial_digits(N)

    greater_count = 0
    for n in range(1, N + 1):
        for r in range(1, n + 1):
            comb_digits = fac_digits[n] - fac_digits[r] - fac_digits[n - r]
            if comb_digits >= 7:
                greater_count += 1
            elif comb_digits >= 5:
                comb = 1
                for i in range(r + 1, n + 1):
                    comb *= i
                for i in range(2, n - r + 1):
                    comb /= i
                if comb >= 1000000:
                    greater_count += 1

    print(greater_count)


def get_factorial_digits(limit):
    """Get number of digits in each factorial"""

    factorials = [1]

    digits = [1]
    for num in range(1, limit + 1):
        new_digits = []
        carry = 0
        for digit in digits:
            digit_product = digit * num + carry
            new_digits.append(int(str(digit_product)[-1]))
            if digit_product >= 10:
                carry = int(str(digit_product)[:-1])
            else:
                carry = 0
        if carry:
            new_digits.extend([int(i) for i in reversed(str(carry))])
        factorials.append(len(new_digits))
        digits = new_digits

    return factorials

if __name__ == '__main__':
    main()
