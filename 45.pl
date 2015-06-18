#!/usr/bin/env perl

# PODNAME: 45.pl
# ABSTRACT: Triangular, pentagonal, and hexagonal

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-06-18

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $KNOWN => 40_755;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $limit = 10_000;    ## no critic (ProhibitMagicNumbers)
my %number_count;
my @n           = ( 1, 1, 1 );
my @last_number = ( 1, 1, 1 );
my @functions   = (
    sub { my $n = shift; return $n * ( $n + 1 ) / 2 },
    ## no critic (ProhibitMagicNumbers)
    sub { my $n = shift; return $n * ( 3 * $n - 1 ) / 2 },
    ## use critic
    sub { my $n = shift; return $n * ( 2 * $n - 1 ) },
);
my @match;

while ( !@match ) {
    $limit *= 10;    ## no critic (ProhibitMagicNumbers)
    foreach my $i ( 0 .. 2 ) {
        while ( $last_number[$i] < $limit ) {
            $n[$i]++;
            $last_number[$i] = $functions[$i]->( $n[$i] );
            $number_count{ $last_number[$i] }++;
        }
    }
    ## no critic (ProhibitMagicNumbers)
    @match = grep { $number_count{$_} == 3 && $_ != $KNOWN } keys %number_count;
    ## use critic
}

printf "%d\n", ( sort { $a <=> $b } @match )[0];

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
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

45.pl

Triangular, pentagonal, and hexagonal

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Triangular, pentagonal, and
hexagonal". The problem is: Find the next triangle number that is also
pentagonal and hexagonal.

=head1 EXAMPLES

    perl 45.pl

=head1 USAGE

    45.pl
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

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
