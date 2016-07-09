#!/usr/bin/env perl

# PODNAME: 111.pl
# ABSTRACT: Primes with runs

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-07-09

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use List::Util qw(sum);
use Algorithm::Combinatorics qw(combinations variations_with_repetition);

# Default options
my $n = 10;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $sum = 0;
## no critic (ProhibitMagicNumbers)
foreach my $d ( 0 .. 9 ) {
    my @other_digits = grep { $_ != $d } ( 0 .. 9 );
    ## use critic
    my $non_rep_digits = 0;
    while (1) {
        $non_rep_digits++;
        my @primes;
        my $base = $d x $n;
        my $combs = combinations( [ 0 .. $n - 1 ], $non_rep_digits );
        while ( my $comb = $combs->next ) {
            my $perms =
              variations_with_repetition( \@other_digits, $non_rep_digits );
            while ( my $perm = $perms->next ) {
                my $num = $base;
                foreach my $i ( 0 .. $non_rep_digits - 1 ) {
                    substr $num, $comb->[$i], 1, $perm->[$i];
                }
                next if $num =~ m/\A 0/xms;
                if ( is_prime($num) ) {
                    push @primes, $num;
                }
            }
        }
        if (@primes) {
            $sum += sum(@primes);
            last;
        }
    }
}

printf "%d\n", $sum;

sub is_prime {
    my ($num) = @_;

    return 0 if $num == 1;    # 1 isn't prime
    ## no critic (ProhibitMagicNumbers)
    return 1 if $num < 4;         # 2 and 3 are prime
    return 0 if $num % 2 == 0;    # Even numbers aren't prime
    return 1 if $num < 9;         # 5 and 7 are prime
    return 0 if $num % 3 == 0;    # Numbers divisible by 3 aren't prime
    ## use critic

    my $num_sqrt = int sqrt $num;
    my $factor   = 5;               ## no critic (ProhibitMagicNumbers)
    while ( $factor <= $num_sqrt ) {
        return 0 if $num % $factor == 0;    # Primes greater than three are 6k-1
        return 0 if $num % ( $factor + 2 ) == 0;    # Or 6k+1
        $factor += 6;    ## no critic (ProhibitMagicNumbers)
    }
    return 1;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'n=i'   => \$n,
        'debug' => \$debug,
        'help'  => \$help,
        'man'   => \$man,
    ) or pod2usage(2);

    # Documentation
    if ($help) {
        pod2usage(1);
    }
    elsif ($man) {
        pod2usage( -verbose => 2 );
    }

    return;
}

__END__
=pod

=encoding UTF-8

=head1 NAME

111.pl

Primes with runs

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Primes with runs". The problem is:
Find the sum of all S(10, d).

=head1 EXAMPLES

    perl 111.pl

=head1 USAGE

    111.pl
        [--n INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--n INT>

The number of digits in the primes.

=item B<--debug>

Print debugging information.

=item B<--help>

Print a brief help message and exit.

=item B<--man>

Print this script's manual page and exit.

=back

=head1 DEPENDENCIES

None

=head1 AUTHOR

=over 4

=item *

Ian Sealy <ian.sealy@sanger.ac.uk>

=back

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2016 by Genome Research Ltd.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
