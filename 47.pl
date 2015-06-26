#!/usr/bin/env perl

# PODNAME: 47.pl
# ABSTRACT: Distinct primes factors

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-06-24

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my $target = 4;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $limit = 100;    ## no critic (ProhibitMagicNumbers)
my $first;
while ( !defined $first ) {
    $limit *= 10;    ## no critic (ProhibitMagicNumbers)
    my @sieve;
    my $consecutive = 0;
    foreach my $i ( 2 .. $limit ) {
        if ( !$sieve[ $i - 2 ] ) {
            my $j = 2 * $i;
            while ( $j <= $limit ) {
                $sieve[ $j - 2 ]++;
                $j += $i;
            }
        }
        if ( defined $sieve[ $i - 2 ] && $sieve[ $i - 2 ] == $target ) {
            $consecutive++;
            if ( $consecutive == $target ) {
                $first = $i - $target + 1;
                last;
            }
        }
        else {
            $consecutive = 0;
        }
    }
}

printf "%d\n", $first;

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'target=i' => \$target,
        'debug'    => \$debug,
        'help'     => \$help,
        'man'      => \$man,
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

47.pl

Distinct primes factors

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Distinct primes factors". The
problem is: Find the first four consecutive integers to have four distinct prime
factors. What is the first of these numbers?

=head1 EXAMPLES

    perl 47.pl

=head1 USAGE

    47.pl
        [--target INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--target INT>

The target number of consecutive integers and distinct prime factors.

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
