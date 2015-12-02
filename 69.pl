#!/usr/bin/env perl

# PODNAME: 69.pl
# ABSTRACT: Totient maximum

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-09-07

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $limit = 1_000_000;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $n     = 1;
my $prime = 1;
while (1) {
    $prime++;
    next if !is_prime($prime);
    last if $n * $prime > $limit;
    $n *= $prime;
}

printf "%d\n", $n;

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
        'limit=i' => \$limit,
        'debug'   => \$debug,
        'help'    => \$help,
        'man'     => \$man,
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

69.pl

Totient maximum

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Totient maximum". The problem is:
Find the value of n ≤ 1,000,000 for which n/φ(n) is a maximum.

=head1 EXAMPLES

    perl 69.pl

=head1 USAGE

    69.pl
        [--limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

The limit on n.

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

This software is Copyright (c) 2015 by Genome Research Ltd.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
