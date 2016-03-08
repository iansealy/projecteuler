#!/usr/bin/env perl

# PODNAME: 90.pl
# ABSTRACT: Cube digit pairs

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-03-08

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;
use Math::Combinatorics;

# Constants
Readonly our @SQUARES => qw( 01 04 09 16 25 36 49 64 81 );

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $distinct = 0;
## no critic (ProhibitMagicNumbers)
my @combinations = combine( 6, ( 0 .. 9 ) );
## use critic
foreach my $combination1 (@combinations) {
    foreach my $combination2 (@combinations) {
        if ( all_squares( $combination1, $combination2 ) ) {
            $distinct++;
        }
    }
}

printf "%d\n", $distinct / 2;

sub all_squares {
    my ( $comb1, $comb2 ) = @_;

    my @comb1 = add_6_or_9( @{$comb1} );
    my @comb2 = add_6_or_9( @{$comb2} );

    my %not_seen = map { $_ => 1 } @SQUARES;
    foreach my $digit1 (@comb1) {
        foreach my $digit2 (@comb2) {
            delete $not_seen{ $digit1 . $digit2 };
            delete $not_seen{ $digit2 . $digit1 };
        }
    }

    if ( scalar keys %not_seen ) {
        return 0;
    }
    else {
        return 1;
    }
}

sub add_6_or_9 {
    my (@comb) = @_;

    my %comb = map { $_ => 1 } @comb;
    ## no critic (ProhibitMagicNumbers)
    if ( exists $comb{6} || exists $comb{9} ) {
        $comb{6} = 1;
        $comb{9} = 1;
    }
    ## use critic
    @comb = sort keys %comb;

    return @comb;
}

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

90.pl

Cube digit pairs

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Cube digit pairs". The problem is:
How many distinct arrangements of the two cubes allow for all of the square
 numbers to be displayed?

=head1 EXAMPLES

    perl 90.pl

=head1 USAGE

    90.pl
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

This software is Copyright (c) 2016 by Genome Research Ltd.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
