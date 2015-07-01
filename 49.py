#!/usr/bin/env python

"""This script solves the Project Euler problem "Prime permutations". The
problem is: What 12-digit number do you form by concatenating the three terms
in this sequence?
"""

from __future__ import division
import math
import itertools


def main():
    """Prime permutations"""

    # Constants
    KNOWN = 148748178147

    primes = get_primes_up_to(9999)
    primes = [prime for prime in primes if prime >= 1000]

    perm_group = {}
    for prime in primes:
        ordered_digits = ''.join(sorted(str(prime)))
        if ordered_digits not in perm_group:
            perm_group[ordered_digits] = []
        perm_group[ordered_digits].append(prime)

    try:
        groups = [grp for grp in perm_group.itervalues() if len(grp) >= 3]
    except AttributeError:
        groups = [grp for grp in perm_group.values() if len(grp) >= 3]

    output = None
    for group in groups:
        for group3 in itertools.combinations(group, 3):
            if group3[1] - group3[0] == group3[2] - group3[1]:
                concat = ''.join([str(i) for i in group3])
                if int(concat) != KNOWN:
                    output = concat

    print(output)


def get_primes_up_to(limit):
    """Get all primes up to specified limit"""

    sieve_bound = (limit - 1) // 2  # Last index of sieve
    sieve = [False for _ in range(sieve_bound)]
    cross_limit = (math.sqrt(limit) - 1) // 2

    i = 1
    while i <= cross_limit:
        if not sieve[i - 1]:
            # 2 * $i + 1 is prime, so mark multiples
            j = 2 * i * (i + 1)
            while j <= sieve_bound:
                sieve[j - 1] = True
                j += 2 * i + 1
        i += 1

    primes = [2 * n + 1 for n in range(1, sieve_bound + 1) if not sieve[n - 1]]
    primes.insert(0, 2)

    return(primes)

if __name__ == '__main__':
    main()
