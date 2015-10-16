#!/usr/bin/env perl

# PODNAME: 79.pl
# ABSTRACT: Passcode derivation

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-10-16

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;
use LWP::Simple;

# Constants
Readonly our $TRIPLETS_URL =>
  'https://projecteuler.net/project/resources/p079_keylog.txt';

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $triplets = get($TRIPLETS_URL);
my @triplets = split /\n/xms, $triplets;

my %after;
foreach my $triplet (@triplets) {
    my ( $digit1, $digit2, $digit3 ) = split //xms, $triplet;
    $after{$digit1}{$digit2} = 1;
    $after{$digit1}{$digit3} = 1;
    $after{$digit2}{$digit3} = 1;
    if ( !exists $after{$digit3} ) {
        $after{$digit3} = {};
    }
}

my $passcode = q{};
foreach my $digit (
    reverse sort { scalar keys %{ $after{$a} } <=> scalar keys %{ $after{$b} } }
    keys %after
  )
{
    $passcode .= $digit;
}

printf "%s\n", $passcode;

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

79.pl

Passcode derivation

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Passcode derivation". The problem
is: Given that the three characters are always asked for in order, analyse the
file so as to determine the shortest possible secret passcode of unknown length.

=head1 EXAMPLES

    perl 79.pl

=head1 USAGE

    79.pl
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
