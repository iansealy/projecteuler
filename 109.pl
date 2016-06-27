#!/usr/bin/env perl

# PODNAME: 109.pl
# ABSTRACT: Darts

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-06-27

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

use Readonly;

# Constants
Readonly our @SINGLES => ( 1 .. 20, 25 );
Readonly our @DOUBLES => map { $_ * 2 } ( 1 .. 20, 25 );
Readonly our @TREBLES => map { $_ * 3 } 1 .. 20;
Readonly our @ALL => sort { $a <=> $b } ( @SINGLES, @DOUBLES, @TREBLES );
Readonly our $MAX => 99;

my @ways;

# One dart
foreach my $double (@DOUBLES) {
    $ways[$double]++;
}

# Two darts
foreach my $dart1 (@ALL) {
    foreach my $double (@DOUBLES) {
        $ways[ $dart1 + $double ]++;
    }
}

# Three darts
foreach my $idx1 ( 0 .. scalar @ALL - 1 ) {
    foreach my $idx2 ( $idx1 .. scalar @ALL - 1 ) {
        foreach my $double (@DOUBLES) {
            $ways[ $ALL[$idx1] + $ALL[$idx2] + $double ]++;
        }
    }
}

my $total = 0;
foreach my $idx ( 1 .. $MAX ) {
    if ( defined $ways[$idx] ) {
        $total += $ways[$idx];
    }
}

printf "%d\n", $total;

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

101.pl

Optimum polynomial

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Darts". The problem is: How many
distinct ways can a player checkout with a score less than 100?

=head1 EXAMPLES

    perl 109.pl

=head1 USAGE

    109.pl
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
