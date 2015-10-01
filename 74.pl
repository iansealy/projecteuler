#!/usr/bin/env perl

# PODNAME: 74.pl
# ABSTRACT: Digit factorial chains

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-10-01

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $LIMIT  => 1_000_000;
Readonly our $TARGET => 60;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @factorials = get_factorials_up_to(9);    ## no critic (ProhibitMagicNumbers)

my %chain_length_for;
my $target_count = 0;
foreach my $num ( 0 .. $LIMIT - 1 ) {

    # Check cache
    my $sorted_digits = join q{}, sort split //xms, $num;
    if ( exists $chain_length_for{$sorted_digits} ) {
        if ( $chain_length_for{$sorted_digits} == $TARGET ) {
            $target_count++;
        }
        next;
    }

    my $chain_length = 1;
    my $chain_num    = $num;
    my %seen         = ( $num => 1 );
    while (1) {
        my @digits = split //xms, $chain_num;
        $chain_num = 0;
        foreach my $digit (@digits) {
            $chain_num += $factorials[$digit];
        }
        last if exists $seen{$chain_num};
        $seen{$chain_num} = 1;
        $chain_length++;
    }

    # Cache
    $chain_length_for{$num} = $chain_length;
    if ( $chain_length == $TARGET ) {
        $target_count++;
    }
}

printf "%d\n", $target_count;

sub get_factorials_up_to {
    my ($limit) = @_;

    my @factorials = (1);    ## no critic (ProhibitReusedNames)
    my $factorial  = 1;
    foreach my $num ( 1 .. $limit ) {
        $factorial *= $num;
        $factorials[$num] = $factorial;
    }

    return @factorials;
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

74.pl

Digit factorial chains

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Digit factorial chains". The
problem is: How many chains, with a starting number below one million, contain
exactly sixty non-repeating terms?

=head1 EXAMPLES

    perl 74.pl

=head1 USAGE

    74.pl
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
