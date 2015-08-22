#!/usr/bin/env perl

# PODNAME: 65.pl
# ABSTRACT: Convergents of e

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-08-22

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Math::BigInt;

# Default options
my $limit = 100;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @a = (2);
## no critic (ProhibitMagicNumbers)
foreach my $n ( 1 .. int( ( $limit - 1 ) / 3 ) + 1 ) {
    ## use critic
    push @a, 1, 2 * $n, 1;
}

## no critic (ProhibitMagicNumbers)
my @numer = ( Math::BigInt->new(2), Math::BigInt->new(3) );
## use critic
foreach my $n ( 2 .. $limit - 1 ) {
    ## no critic (ProhibitMagicNumbers)
    push @numer, $a[$n] * $numer[-1] + $numer[-2];
    ## use critic
}

my $sum = 0;
foreach my $digit ( split //xms, $numer[-1] ) {
    $sum += $digit;
}

printf "%d\n", $sum;

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

65.pl

Convergents of e

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Convergents of e". The problem is:
Find the sum of digits in the numerator of the 100th convergent of the continued
fraction for e.

=head1 EXAMPLES

    perl 65.pl

=head1 USAGE

    65.pl
        [--limit INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

The number of convergents.

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
