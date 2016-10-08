#!/usr/bin/env perl

# PODNAME: 130.pl
# ABSTRACT: Composites with prime repunit property

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-10-08

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use List::Util qw(sum);

# Default options
my $limit = 25;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @composite;
my $n = 90;        ## no critic (ProhibitMagicNumbers)
while ( scalar @composite < $limit ) {
    $n++;
    next if $n % 2 == 0 || $n % 5 == 0;    ## no critic (ProhibitMagicNumbers)
    next if is_prime($n);
    my $rkmodn = 1;
    my $k      = 1;
    while ( $rkmodn % $n != 0 ) {
        $k++;
        $rkmodn = ( $rkmodn * 10 + 1 ) % $n; ## no critic (ProhibitMagicNumbers)
    }
    next if ( $n - 1 ) % $k != 0;
    push @composite, $n;
}

printf "%d\n", sum(@composite);

sub is_prime {
    my ($num) = @_;

    return 0 if $num == 1;                   # 1 isn't prime
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

130.pl

Composites with prime repunit property

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Composites with prime repunit
property". Find the sum of the first twenty-five composite values of n for which
GCD(n, 10) = 1 and n - 1 is divisible by A(n).

=head1 EXAMPLES

    perl 130.pl --limit 5

=head1 USAGE

    130.pl
        [--limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

The number of composite values to sum.

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
